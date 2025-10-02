import "byllm";
import "os";

node JacTutor {
    has byllm.LLM llm;

    def init() {
        # Pull key from environment variable GOOGLE_API_KEY
        api_key = os.getenv("GOOGLE_API_KEY");
        if api_key == null {
            print("⚠️ No API key found. Run: export GOOGLE_API_KEY='your_key_here'");
            return;
        }

        self.llm = byllm.LLM(
            provider="gemini",
            model="models/gemini-2.5-flash",
            api_key=api_key
        );
    }

    can ask(question: str) -> str {
        response = self.llm.chat(prompt=question);
        return response["output_text"];
    }
}

with entry {
    tutor = JacTutor(); # no key passed, pulls from env
    print("Welcome to the Jac Tutor ⚡");
    print("Ask me anything about Jac/Jaseci setup!");

    while true {
        q = input("You: ");
        if q == "exit" {
            print("Goodbye Zeus ⚡");
            break;
        }
        answer = tutor.ask(q);
        print(f"Tutor: {answer}");
    }
}
