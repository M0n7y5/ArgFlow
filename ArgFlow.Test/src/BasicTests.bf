using System;
using ArgFlow;
using ArgFlow.Attributes;
namespace ArgFlow.Test;

class BasicTests
{
	class Globals
	{
		[Option(shortName = "")]
		public bool Verbose { get; set; }
	}

	[SubCommand]
	class SubTest
	{
		//[Option<String>(String.Empty, "i", "input")]
		public String InputPath;

		//[Option<String>(String.Empty, "o", "output")]
		public String OutputPath;

		public Result<void> Invoke()
		{
			scope OptionAttribute();

			//...
			return .Err;
		}
	}


	[Test]
	public static void T_Basic()
	{
		/*let foo = scope SubTest();

		let bar = foo();*/

		//let hash = XHash64.Hash("fsfsddddddddddddddddddddddddddddddddd", 0);

		let args = scope ArgFlow()
			.WithGlobalOptions<Globals>()
			.Parse("lol som args --version -q");
	}
}	