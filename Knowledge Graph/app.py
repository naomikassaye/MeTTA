import streamlit as st
import os
from dotenv import load_dotenv
from pydantic import SecretStr
from langchain_neo4j import Neo4jGraph, GraphCypherQAChain 
from langchain_groq import ChatGroq
from hyperon import MeTTa 

load_dotenv()

st.set_page_config(page_title="MeTTa Reasoning Graph", page_icon="🧠")
st.title("Learning Graph + MeTTa Inheritance")

def run_metta_reasoning(obj_name):
    metta = MeTTa()
    with open("logic.metta", "r") as f:
        metta_code = f.read()
    
    query = f"!(getprop {obj_name} difficulty)"
    result = metta.run(metta_code + "\n" + query)
    return result

@st.cache_resource
def setup_chain():
    graph = Neo4jGraph(url=os.getenv("NEO4J_URI"), username=os.getenv("NEO4J_USERNAME"), password=os.getenv("NEO4J_PASSWORD"), enhanced_schema=False)
    groq_key = os.getenv("GROQ_API_KEY")
    if groq_key is None:
        raise RuntimeError("GROQ_API_KEY environment variable is not set")
    llm = ChatGroq(model="llama-3.3-70b-versatile", api_key=SecretStr(groq_key), temperature=0)
    return GraphCypherQAChain.from_llm(llm=llm, graph=graph, verbose=True, allow_dangerous_requests=True)

try:
    chain = setup_chain()
    
    with st.sidebar:
        st.header(" MeTTa Symbolic Logic")
        test_obj = st.text_input("Enter Topic to Reason About (e.g. Python)", "Python")
        if st.button("Run MeTTa Logic"):
            reasoning_result = run_metta_reasoning(test_obj)
            st.write(f"Result for {test_obj}:")
            st.code(reasoning_result)

    if prompt := st.chat_input("Ask a roadmap question..."):
        with st.chat_message("user"): st.markdown(prompt)
        with st.chat_message("assistant"):
            response = chain.invoke({"query": prompt})
            st.markdown(response["result"])

except Exception as e:
    st.error(f"Error: {e}")