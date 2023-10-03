using System;
using System.Collections;
using System.Diagnostics;
using ArgFlow.Attributes;

namespace ArgFlow;


/*
I decided to use this guideline for CLI syntax parser
https://learn.microsoft.com/en-us/dotnet/standard/commandline/syntax
*/

public sealed class ArgFlow : IDisposable
{
	//Global options
	Object _globalOptions = null ~ DelIfNotNull!(_);

	Type _globalOptionsType = null ~ DelIfNotNull!(_);

	// Global string for general errors
	String _parseErrorMessage = new .() ~ delete _;

	Dictionary<uint64, Object> _subcommands;

	mixin DelIfNotNull(Object obj)
	{
		if (obj != null)
			delete obj;
	}

	mixin ReturnErrorMsg(String msg)
	{
		_parseErrorMessage.Clear();
		_parseErrorMessage.Append(msg);
		return .Err(_parseErrorMessage);
	}

	public Self WithGlobalOptions<T>() where T : class
	{
		_globalOptionsType = typeof(T);

		return this;
	}

	//TODO: return errors as enum payload
	public Result<void, String> Parse(StringView arguments)
	{
		Runtime.Assert(_globalOptionsType != null, "Global options cannot be empty!");

		for (let type in Type.Types)
		{
			if (type.HasCustomAttribute<SubCommandAttribute>())
			{
				let fieldC = type.FieldCount;
			}
		}


		/*
		Prepare stage:
		1. Resolve all registered options in Global Options Type
		2. Resolve all subcomands and its options
		3. Build help page

		Parsing Stage:
		1. Parse global options first
		2. Parse subcommand
		3. Execute subcommand

		If Error
			- Show help message
			- Show argument error + verbose description about correct argument format
		*/

		return .Ok;
	}

	public void Dispose()
	{
	}
}