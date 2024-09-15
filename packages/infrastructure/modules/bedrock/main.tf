resource "aws_bedrockagent_agent" "subject_bedrock_agent" {
  agent_name              = "SubjectPickerAgent"
  foundation_model        = "anthropic.claude-3-haiku-20240307-v1:0"
  agent_resource_role_arn = var.subject_agent_role_arn

  idle_session_ttl_in_seconds = 60
  instruction                 = file("${path.module}/modules/bedrock/instructions/subject_picker.yml")
  description                 = "Agent to subtract subjects from the user query"

}
