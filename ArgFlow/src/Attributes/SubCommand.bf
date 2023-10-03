using System;
namespace ArgFlow.Attributes;

[AttributeUsage(.Class, .AlwaysIncludeTarget | .ReflectAttribute)]
struct SubCommandAttribute : Attribute
{
	public String Name { get; set mut; }
}