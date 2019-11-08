require ["fileinto"];
# rule:[SPAM]
if allof (header :contains "subject" "[SPAM]")
{
	fileinto "Spam";
	stop;
}
