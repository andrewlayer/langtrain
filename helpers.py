import json

def convert_to_json(data):
    json_string = json.dumps(dict(data))
    return json_string
