using System;
using System.IO;
using IronRuby;
using Microsoft.Scripting.Hosting;

namespace BugTracker_40
{
    public class Bug
    {
        public string Title  { get;	private set; }
		
        public string Assignee  { get; private set; }
		
        public dynamic Statemachine  { get; set; }
		
        public string DefinitionPath  { get; set; }
		
        private static readonly ScriptEngine Engine = Ruby.CreateEngine();
				
        public Bug(string title)
        {
            DefinitionPath = Path.Combine(
                Environment.CurrentDirectory, "definition.rb"
                );
            Title = title;			
			
            ExecuteRubyDefinition();
        }
		
        private void ExecuteRubyDefinition(){
            var scope = Engine.CreateScope();
            scope.SetVariable("ctxt", this);
            Engine.ExecuteFile(DefinitionPath, scope);
        }
		
        public virtual void Deassign(){
            Assignee = null;
        }
		
        public virtual void OnAssigned(string assignee)
        {
            if (Assignee != null && assignee != Assignee)
                SendEmailToAssignee("Don't forget to help the new guy.");

            Assignee = assignee;
            SendEmailToAssignee("You own it.");
        }

        public virtual void Deassigned()
        {
            if(Assignee != null) SendEmailToAssignee("You're off the hook."); // Deassign needs Assignee
        }

        public virtual void SendEmailToAssignee(string message)
        {
            Console.WriteLine("{0}, RE {1}: {2}", Assignee, Title, message);
        }
		
        public virtual void Assign(string assignee){
            Statemachine.assign(assignee);
        }
		
        public virtual void Defer(){
            Statemachine.defer();
        }
		
        public virtual void Close(){
            Statemachine.close();
        }
		
    }
}