using System;
namespace ArgFlow;

public static class XHash64
{
	private const uint64 XXH_PRIME64_1 = 11400714785074694791UL;
	private const uint64 XXH_PRIME64_2 = 14029467366897019727UL;
	private const uint64 XXH_PRIME64_3 = 1609587929392839161UL;
	private const uint64 XXH_PRIME64_4 = 9650029242287828579UL;
	private const uint64 XXH_PRIME64_5 = 2870177450012600261UL;

	[Inline, Comptime(ConstEval = true)]
	public static uint64 Hash(StringView str, uint64 seed = 0)
	{
		return Hash((.)str.ToRawData().Ptr, str.ToRawData().Length, seed);
	}

	[Inline]
	static uint64 Hash(uint8* input, int len, uint64 seed)
	{
		var input;
		var len;
		uint64 h64;

		if (len >= 32)
		{
			uint8* end = input + len;
			uint8* limit = end - 31;

			uint64 v1 = seed + XXH_PRIME64_1 + XXH_PRIME64_2;
			uint64 v2 = seed + XXH_PRIME64_2;
			uint64 v3 = seed + 0;
			uint64 v4 = seed - XXH_PRIME64_1;

			repeat
			{
				var reg1 = *((uint64*)(input + 0));
				var reg2 = *((uint64*)(input + 8));
				var reg3 = *((uint64*)(input + 16));
				var reg4 = *((uint64*)(input + 24));

				// XXH64_round
				v1 += reg1 * XXH_PRIME64_2;
				v1 = (v1 << 31) | (v1 >> (64 - 31));
				v1 *= XXH_PRIME64_1;

				// XXH64_round
				v2 += reg2 * XXH_PRIME64_2;
				v2 = (v2 << 31) | (v2 >> (64 - 31));
				v2 *= XXH_PRIME64_1;

				// XXH64_round
				v3 += reg3 * XXH_PRIME64_2;
				v3 = (v3 << 31) | (v3 >> (64 - 31));
				v3 *= XXH_PRIME64_1;

				// XXH64_round
				v4 += reg4 * XXH_PRIME64_2;
				v4 = (v4 << 31) | (v4 >> (64 - 31));
				v4 *= XXH_PRIME64_1;
				input += 32;

				let withinLimit = input < limit;
			} while (input < limit);

			h64 = ((v1 << 1) | (v1 >> (64 - 1))) +
				((v2 << 7) | (v2 >> (64 - 7))) +
				((v3 << 12) | (v3 >> (64 - 12))) +
				((v4 << 18) | (v4 >> (64 - 18)));

			// XXH64_mergeRound
			v1 *= XXH_PRIME64_2;
			v1 = (v1 << 31) | (v1 >> (64 - 31));
			v1 *= XXH_PRIME64_1;
			h64 ^= v1;
			h64 = h64 * XXH_PRIME64_1 + XXH_PRIME64_4;

			// XXH64_mergeRound
			v2 *= XXH_PRIME64_2;
			v2 = (v2 << 31) | (v2 >> (64 - 31));
			v2 *= XXH_PRIME64_1;
			h64 ^= v2;
			h64 = h64 * XXH_PRIME64_1 + XXH_PRIME64_4;

			// XXH64_mergeRound
			v3 *= XXH_PRIME64_2;
			v3 = (v3 << 31) | (v3 >> (64 - 31));
			v3 *= XXH_PRIME64_1;
			h64 ^= v3;
			h64 = h64 * XXH_PRIME64_1 + XXH_PRIME64_4;

			// XXH64_mergeRound
			v4 *= XXH_PRIME64_2;
			v4 = (v4 << 31) | (v4 >> (64 - 31));
			v4 *= XXH_PRIME64_1;
			h64 ^= v4;
			h64 = h64 * XXH_PRIME64_1 + XXH_PRIME64_4;
		}
		else
		{
			h64 = seed + XXH_PRIME64_5;
		}

		h64 += (uint64)len;

		// XXH64_finalize
		len &= 31;
		while (len >= 8)
		{
			uint64 k1 = XXH64_round(0, *(uint64*)input);
			input += 8;
			h64 ^= k1;
			h64  = XXH_rotl64(h64, 27) * XXH_PRIME64_1 + XXH_PRIME64_4;
			len -= 8;
		}
		if (len >= 4)
		{
			h64 ^= *(uint32*)input * XXH_PRIME64_1;
			input += 4;
			h64 = XXH_rotl64(h64, 23) * XXH_PRIME64_2 + XXH_PRIME64_3;
			len -= 4;
		}
		while (len > 0)
		{
			h64 ^= (*input++) * XXH_PRIME64_5;
			h64 = XXH_rotl64(h64, 11) * XXH_PRIME64_1;
			--len;
		}

		// XXH64_avalanche
		h64 ^= h64 >> 33;
		h64 *= XXH_PRIME64_2;
		h64 ^= h64 >> 29;
		h64 *= XXH_PRIME64_3;
		h64 ^= h64 >> 32;

		return h64;
	}

	[Inline]
	private static uint64 XXH_rotl64(uint64 x, int32 r)
	{
		return (x << r) | (x >> (64 - r));
	}


	[Inline]
	private static uint64 XXH64_round(uint64 acc, uint64 input)
	{
		var acc;
		acc += input * XXH_PRIME64_2;
		acc  = XXH_rotl64(acc, 31);
		acc *= XXH_PRIME64_1;
		return acc;
	}
}