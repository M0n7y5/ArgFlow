using System;

namespace ArgFlow.App;

class Program
{
	/*[Export, LinkName(.C)]
	static uint32 NvOptimusEnablement = 1;

	[Export, LinkName(.C)]
	static int32 AmdPowerXpressRequestHighPerformance  = 1;*/

	public static int Main(String[] args)
	{
		let hash = XHash64.Hash("fsfsddddddddddddddddddddddddddddddddd", 0);

		if (hash > 0)
		{
			Console.WriteLine("sus");
		}

		return 0;
	}
}