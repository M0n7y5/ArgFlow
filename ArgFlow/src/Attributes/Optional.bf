using System;
namespace ArgFlow.Attributes;

[AttributeUsage(
	.Method | .Parameter | .Property | .Field,
	.AlwaysIncludeTarget | .ReflectAttribute)]
struct OptionalAttribute : Attribute
{
}