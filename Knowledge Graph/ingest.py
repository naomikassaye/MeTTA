import os
from langchain_neo4j import Neo4jGraph 
from dotenv import load_dotenv


load_dotenv()

def seed_database():
    print("Checking connection...")
    try:
       
        graph = Neo4jGraph(
            url=os.getenv("NEO4J_URI"),
            username=os.getenv("NEO4J_USERNAME"),
            password=os.getenv("NEO4J_PASSWORD"),
            enhanced_schema=False  
        )

        cypher_query = """
        // --- DATA SCIENCE & AI CLUSTER ---
        MERGE (t1:Topic {name: "Python"}) SET t1.difficulty = "Beginner"
        MERGE (t2:Topic {name: "Data Science"}) SET t2.difficulty = "Intermediate"
        MERGE (t3:Topic {name: "Machine Learning"}) SET t3.difficulty = "Advanced"
        MERGE (t_ai:Topic {name: "Deep Learning"}) SET t_ai.difficulty = "Advanced"
        MERGE (t_genai:Topic {name: "Generative AI"}) SET t_genai.difficulty = "Advanced"

        // --- WEB DEVELOPMENT CLUSTER ---
        MERGE (t4:Topic {name: "HTML & CSS"}) SET t4.difficulty = "Beginner"
        MERGE (t5:Topic {name: "JavaScript"}) SET t5.difficulty = "Intermediate"
        MERGE (t6:Topic {name: "React"}) SET t6.difficulty = "Advanced"

        // --- DATABASE CLUSTER ---
        MERGE (t7:Topic {name: "SQL"}) SET t7.difficulty = "Beginner"
        MERGE (t8:Topic {name: "Database Design"}) SET t8.difficulty = "Intermediate"

        // --- RESOURCES ---
        MERGE (r1:Resource {name: "Automate the Boring Stuff", type: "Book"})
        MERGE (r2:Resource {name: "Andrew Ng ML Specialization", type: "Course"})
        MERGE (r3:Resource {name: "FreeCodeCamp Web Dev", type: "Website"})
        MERGE (r4:Resource {name: "SQLZoo Interactive", type: "Website"})
        MERGE (r5:Resource {name: "DeepLearning.AI GenAI", type: "Course"})
        MERGE (r6:Resource {name: "JavaScript.info", type: "Website"})

        // --- RELATIONSHIPS (The Roadmaps) ---
        
        // AI Path
        MERGE (t1)-[:PREREQUISITE_FOR]->(t2)
        MERGE (t2)-[:PREREQUISITE_FOR]->(t3)
        MERGE (t3)-[:PREREQUISITE_FOR]->(t_ai)
        MERGE (t_ai)-[:PREREQUISITE_FOR]->(t_genai)

        // Web Path
        MERGE (t4)-[:PREREQUISITE_FOR]->(t5)
        MERGE (t5)-[:PREREQUISITE_FOR]->(t6)

        // Database Path
        MERGE (t7)-[:PREREQUISITE_FOR]->(t8)
        
        // Cross-Path (You need SQL for Data Science!)
        MERGE (t7)-[:PREREQUISITE_FOR]->(t2)

        // Mapping Resources to Topics
        MERGE (r1)-[:TEACHES]->(t1)
        MERGE (r2)-[:TEACHES]->(t3)
        MERGE (r3)-[:TEACHES]->(t4)
        MERGE (r4)-[:TEACHES]->(t7)
        MERGE (r5)-[:TEACHES]->(t_genai)
        MERGE (r6)-[:TEACHES]->(t5)
        """
        
        graph.query(cypher_query)
        print("SUCCESS")
        
    except Exception as e:
        print("FAILED TO CONNECT")
        print(f"Error details: {e}")

if __name__ == "__main__":
    seed_database()