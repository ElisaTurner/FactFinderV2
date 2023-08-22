# FactFinder

Use this application to input and query facts. 

1. Install Elixir.
2. Clone the repository:
git clone [github link](https://github.com/ElisaTurner/FactFinderV2)
3. Navigate to the directory:
4. cd fact_finder_application
5. Run the following command to compile the code:
 mix compile
6. Run the following command to start the server:
iex -S mix
7. You can now input facts and queries:
- import FactFinder
- import FactMap
- FactFinder.input_fact("is_a_cat (lucy)")
    Inputs that lucy is a cat 
- FactFinder.input_fact("are_friends (alex, sam)")
    Inputs that alex, sam are friends. 
- FactFinder.input_fact("is_a_cat (Jenna)")
 and i can input that someone else is a cat and it wont override the last cat. 
- FactFinder.query_facts("is_a_cat (X)")
    Will result in a list of everyone who is a cat
- FactFinder.match_fact("is_a_cat (lucy)")    
    Will return true if there is a match in our facts.txt file of the fact that lucy is a cat. 

 


 
