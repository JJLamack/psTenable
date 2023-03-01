<#
.SYNOPSIS

Adds Powershell 7 auto completion type to Windows PowerShell

.DESCRIPTION

Detects if we are running on Windows Powershell. Adds ArguementCompletions Type 

.NOTES

Code taken from powershell.one to add Powershell 7 functionality in Windows PowerShell

https://powershell.one/powershell-internals/attributes/auto-completion

#>

# are we running in Windows PowerShell?
if ($PSVersionTable.PSEdition -ne 'Core')
{
  # add the attribute [ArgumentCompletions()]:
  $code = @'
using System;
using System.Collections.Generic;
using System.Management.Automation;

    public class ArgumentCompletionsAttribute : ArgumentCompleterAttribute
    {
        
        private static ScriptBlock _createScriptBlock(params string[] completions)
        {
            string text = "\"" + string.Join("\",\"", completions) + "\"";
            string code = "param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams);@(" + text + ") -like \"*$WordToComplete*\" | Foreach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }";
            return ScriptBlock.Create(code);
        }
        
        public ArgumentCompletionsAttribute(params string[] completions) : base(_createScriptBlock(completions))
        {
        }
    }
'@

  # Add-Type emits a warning that cannot be suppressed by -IgnoreWarning. So output forwards all streams and discards to $null
  $null = Add-Type -TypeDefinition $code *>&1
}