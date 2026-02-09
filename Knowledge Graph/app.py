import streamlit as st
import os
from dotenv import load_dotenv
from pydantic import SecretStr

from langchain_neo4j import Neo4jGraph, GraphCypherQAChain 
from langchain_groq import ChatGroq
from langchain_core.prompts.prompt import PromptTemplate

load_dotenv()

st.set_page_config(page_title="Learning Brain")
st.title(" My Local Learning Brain")

CYPHER_GENERATION_TEMPLATE = """Task: Generate a Cypher statement to query a Neo4j graph database.

Instructions:
1. Use ONLY these Labels and Properties:
   - Resource: 'name', 'type' (Values are usually 'Book' or 'Course')
   - Topic: 'name', 'difficulty' (Values are 'Beginner', 'Intermediate', 'Advanced')
2. Use ONLY these Relationships:
   - (:Resource)-[:TEACHES]->(:Topic)
   - (:Topic)-[:PREREQUISITE_FOR]->(:Topic)
3. For "What to study next" or "Roadmap" questions, use: (t:Topic)-[:PREREQUISITE_FOR*]->(next)
4. Use toLower() for all string comparisons to ensure you find the data regardless of capitalization.
   Example: MATCH (r:Resource) WHERE toLower(r.name) CONTAINS 'python' RETURN r.name

Schema:
{schema}

Question: {question}
Cypher Query:"""

CYPHER_PROMPT = PromptTemplate(
    input_variables=["schema", "question"], 
    template=CYPHER_GENERATION_TEMPLATE
)

@st.cache_resource
def setup_chain():
    graph = Neo4jGraph(
        url=os.getenv("NEO4J_URI"),
        username=os.getenv("NEO4J_USERNAME"),
        password=os.getenv("NEO4J_PASSWORD"),
        enhanced_schema=False
    )
    
    groq_api_key = os.getenv("GROQ_API_KEY")
    assert groq_api_key is not None, "GROQ_API_KEY is not set"
    llm = ChatGroq(
        model="llama-3.3-70b-versatile",
        api_key=SecretStr(groq_api_key),
        temperature=0
    )
    
    return GraphCypherQAChain.from_llm(
        llm=llm, 
        graph=graph, 
        verbose=True, 
        allow_dangerous_requests=True,
        cypher_prompt=CYPHER_PROMPT 
    )

try:
    chain = setup_chain()
    
    if "messages" not in st.session_state:
        st.session_state.messages = []

    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    if prompt := st.chat_input("Ask about your studies..."):
        st.session_state.messages.append({"role": "user", "content": prompt})
        with st.chat_message("user"):
            st.markdown(prompt)

        with st.chat_message("assistant"):
            with st.spinner("Thinking..."):
                result = chain.invoke({"query": prompt})
                output = result["result"]
                st.markdown(output)
                st.session_state.messages.append({"role": "assistant", "content": output})

except Exception as e:
    st.error(f"Something went wrong: {e}")