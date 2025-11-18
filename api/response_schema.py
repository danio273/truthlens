from google.genai import types

FACTOR_SCHEMA = types.Schema(
    type=types.Type.OBJECT,
    properties={
        "status": types.Schema(
            type=types.Type.STRING,
            enum=["verified", "questionable", "false_info"],
            description="The assessment of this factor."
        ),
        "short": types.Schema(
            type=types.Type.STRING,
            description="A one-sentence summary of the factor's analysis (in the original text's language)."
        ),
        "long": types.Schema(
            type=types.Type.STRING,
            description="A detailed paragraph explaining the reasoning for the 'status' (in the original text's language)."
        ),
        "source_links": types.Schema(
            type=types.Type.ARRAY,
            description="A list of 0-based index numbers corresponding to the most relevant sources in the CONTEXT FOR VERIFICATION block.",
            items=types.Schema(type=types.Type.INTEGER)
        ),
    },
    required=["status", "short", "long", "source_links"]
)

FACTORS_SCHEMA = types.Schema(
    type=types.Type.OBJECT,
    description="Required if 'processable' is true. Contains the analysis of the four key factors.",
    properties={
        "source_reliability": FACTOR_SCHEMA,
        "logic_quality": FACTOR_SCHEMA,
        "emotional_pressure": FACTOR_SCHEMA,
        "manipulative_structure": FACTOR_SCHEMA,
    },
    required=[
        "source_reliability",
        "logic_quality",
        "emotional_pressure",
        "manipulative_structure"
    ]
)

RESPONSE_SCHEMA = types.Schema(
    type=types.Type.OBJECT,
    properties={
        "summary": types.Schema(
            type=types.Type.STRING,
            description="A single-sentence, direct, and concise restatement of the input text's core claim, in the original language of the text."
        ),
        "processable": types.Schema(
            type=types.Type.BOOLEAN,
            description="Indicates whether the text is suitable for fact-checking analysis (true/false)."
        ),
        "reason": types.Schema(
            type=types.Type.STRING,
            description="Required if 'processable' is false. A brief explanation (in the original text's language) why the text cannot be analyzed."
        ),
        "factors": FACTORS_SCHEMA,
    },
    required=["processable"]
)