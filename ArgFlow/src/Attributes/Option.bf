using System;
using System.Reflection;
namespace ArgFlow.Attributes;

[AttributeUsage(
	.Parameter | .Property | .Field,
	.AlwaysIncludeTarget | .ReflectAttribute)]
struct OptionAttribute<T> : Attribute,
this(T Default, String shortName, String longName)
{
}