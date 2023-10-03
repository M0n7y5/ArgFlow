using System;
namespace ArgFlow.Attributes;

[AttributeUsage(
	.Method | .Parameter | .Property,
	.AlwaysIncludeTarget | .ReflectAttribute)]
struct DescriptionAttribute : Attribute, this(String description)
{
}