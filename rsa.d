// This software will implement the RSA algorithm in its almost complete form, the numbers will be smaller to make computations faster.

// import all the tools we need
import std.bigint : BigInt;
import std.conv : to;
import std.random : choice, uniform;
import std.stdio : writeln;

// this array contains a long list of primes to choose from
const int[560] primes = [3083, 3089, 3109, 3119, 3121, 3137, 3163, 3167, 3169, 3181, 3187, 3191, 3203, 3209, 3217, 3221, 3229, 3251, 3253, 3257, 3259, 3271, 3299, 3301,
                         3307, 3313, 3319, 3323, 3329, 3331, 3343, 3347, 3359, 3361, 3371, 3373, 3389, 3391, 3407, 3413, 3433, 3449, 3457, 3461, 3463, 3467, 3469, 3491,
                         3499, 3511, 3517, 3527, 3529, 3533, 3539, 3541, 3547, 3557, 3559, 3571, 3581, 3583, 3593, 3607, 3613, 3617, 3623, 3631, 3637, 3643, 3659, 3671,
                         3673, 3677, 3691, 3697, 3701, 3709, 3719, 3727, 3733, 3739, 3761, 3767, 3769, 3779, 3793, 3797, 3803, 3821, 3823, 3833, 3847, 3851, 3853, 3863,
                         3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931, 3943, 3947, 3967, 3989, 4001, 4003, 4007, 4013, 4019, 4021, 4027, 4049, 4051, 4057,
                         4073, 4079, 4091, 4093, 4099, 4111, 4127, 4129, 4133, 4139, 4153, 4157, 4159, 4177, 4201, 4211, 4217, 4219, 4229, 4231, 4241, 4243, 4253, 4259,
                         4261, 4271, 4273, 4283, 4289, 4297, 4327, 4337, 4339, 4349, 4357, 4363, 4373, 4391, 4397, 4409, 4421, 4423, 4441, 4447, 4451, 4457, 4463, 4481,
                         4483, 4493, 4507, 4513, 4517, 4519, 4523, 4547, 4549, 4561, 4567, 4583, 4591, 4597, 4603, 4621, 4637, 4639, 4643, 4649, 4651, 4657, 4663, 4673,
                         4679, 4691, 4703, 4721, 4723, 4729, 4733, 4751, 4759, 4783, 4787, 4789, 4793, 4799, 4801, 4813, 4817, 4831, 4861, 4871, 4877, 4889, 4903, 4909,
                         4919, 4931, 4933, 4937, 4943, 4951, 4957, 4967, 4969, 4973, 4987, 4993, 4999, 5003, 5009, 5011, 5021, 5023, 5039, 5051, 5059, 5077, 5081, 5087,
                         5099, 5101, 5107, 5113, 5119, 5147, 5153, 5167, 5171, 5179, 5189, 5197, 5209, 5227, 5231, 5233, 5237, 5261, 5273, 5279, 5281, 5297, 5303, 5309,
                         5323, 5333, 5347, 5351, 5381, 5387, 5393, 5399, 5407, 5413, 5417, 5419, 5431, 5437, 5441, 5443, 5449, 5471, 5477, 5479, 5483, 5501, 5503, 5507,
                         5519, 5521, 5527, 5531, 5557, 5563, 5569, 5573, 5581, 5591, 5623, 5639, 5641, 5647, 5651, 5653, 5657, 5659, 5669, 5683, 5689, 5693, 5701, 5711,
                         5717, 5737, 5741, 5743, 5749, 5779, 5783, 5791, 5801, 5807, 5813, 5821, 5827, 5839, 5843, 5849, 5851, 5857, 5861, 5867, 5869, 5879, 5881, 5897,
                         5903, 5923, 5927, 5939, 5953, 5981, 5987, 6007, 6011, 6029, 6037, 6043, 6047, 6053, 6067, 6073, 6079, 6089, 6091, 6101, 6113, 6121, 6131, 6133,
                         6143, 6151, 6163, 6173, 6197, 6199, 6203, 6211, 6217, 6221, 6229, 6247, 6257, 6263, 6269, 6271, 6277, 6287, 6299, 6301, 6311, 6317, 6323, 6329,
                         6337, 6343, 6353, 6359, 6361, 6367, 6373, 6379, 6389, 6397, 6421, 6427, 6449, 6451, 6469, 6473, 6481, 6491, 6521, 6529, 6547, 6551, 6553, 6563,
                         6569, 6571, 6577, 6581, 6599, 6607, 6619, 6637, 6653, 6659, 6661, 6673, 6679, 6689, 6691, 6701, 6703, 6709, 6719, 6733, 6737, 6761, 6763, 6779,
                         6781, 6791, 6793, 6803, 6823, 6827, 6829, 6833, 6841, 6857, 6863, 6869, 6871, 6883, 6899, 6907, 6911, 6917, 6947, 6949, 6959, 6961, 6967, 6971,
                         6977, 6983, 6991, 6997, 7001, 7013, 7019, 7027, 7039, 7043, 7057, 7069, 7079, 7103, 7109, 7121, 7127, 7129, 7151, 7159, 7177, 7187, 7193, 7207,
                         7211, 7213, 7219, 7229, 7237, 7243, 7247, 7253, 7283, 7297, 7307, 7309, 7321, 7331, 7333, 7349, 7351, 7369, 7393, 7411, 7417, 7433, 7451, 7457,
                         7459, 7477, 7481, 7487, 7489, 7499, 7507, 7517, 7523, 7529, 7537, 7541, 7547, 7549, 7559, 7561, 7573, 7577, 7583, 7589, 7591, 7603, 7607, 7621,
                         7639, 7643, 7649, 7669, 7673, 7681, 7687, 7691, 7699, 7703, 7717, 7723, 7727, 7741, 7753, 7757, 7759, 7789, 7793, 7817, 7823, 7829, 7841, 7853,
                         7867, 7873, 7877, 7879, 7883, 7901, 7907, 7919];

// this function will calculate the LCM of 2 numbers by factoring them simultaneously and combining all factors
ulong lcm(ulong A, ulong B)
{
    // this variable will hold the result
    ulong result = 1;

    // start a loop to check all possible factors of the numbers, while they are both bigger than 1
    for (ulong factor = 2; A + B > 2;)
        // if 'factor' is a factor of the number 'A'
        if (A % factor == 0)
        {
            // include it in the result and remove it from 'A'
            result *= factor, A /= factor;

            // if 'factor' is also a factor of the number 'B'
            if (B % factor == 0)
                // remove it from 'B'
                B /= factor;
        }
        // if 'factor' is a factor of the number 'B' alone
        else if (B % factor == 0)
            // include it in the result and remove it from 'B'
            result *= factor, B /= factor;
        // if it is not a factor of either of the numbers
        else
            // increment it in order to check the next possible factor, notice it is NOT incremented when it IS a factor (so it's used again)
            factor++;

    // return the result with all the factors combined, meaning the LCM
    return result;
}

// this function will tell if 2 numbers are coprime using the Euclidean algorithm
bool isCoprime(ulong A, ulong B)
{
    // this variable will contain the result of the modulo
    ulong result;

    // start a loop to keep taking the modulo of 'A' and 'B'
    do
        // find 'A % B', store it in 'result' and then make 'A = B' and 'B = result', this is the Euclidean algorithm to find MCD
        result = A % B, A = B, B = result;
    // repeat the loop until 'result' is 0, that is when you've found the MCD
    while (result > 0);

    // due to the loop above we will have the MCD stored in 'A', if it is 1 then the numbers are coprime, return this comparison
    return A == 1;
}

// this function will calculate the power between 2 numbers when the result is super large, too large for an 'ulong'
BigInt power(ulong base, ulong exponent)
{
    // this variable will contain the result
    BigInt result = base;

    // keep running the loop in order to multiply the base by itself until the exponent turns to 1, the exponent is decremented each time
    while (exponent-- > 1)
    {
        // multiply the result by the base again
        result *= base;

        // if the exponent is a multiple of 10000 (this is here only to allow the user to check the progress)
        if (exponent % 10000 == 0)
            // print the exponent to the screen, so the user may see how long it still has to go
            writeln(exponent);
    }

    // return the result with the gigantic number as a 'BigInt'
    return result;
}

void main()
{
    // create the numbers used in the RSA computations
    ulong P, Q, N, T, E, D, M, C;

    // tell the user we are now encrypting the message
    writeln("Encrypting:");

    // start a loop to keep selecting primes from the array above
    do
        // select 'P' and 'Q' randomly from the array 'primes' above
        P = choice(primes[]), Q = choice(primes[]);
    // keep doing it until there is a large difference between them, they should be distant numbers
    while (P - Q < 2500);

    // calculate 'N' as 'P * Q', calculate 'T' as the Carmichael of 'N' (with the 'lcm() function) and set 'E' as 65537 (a widely used value for 'E')
    N = P * Q, T = lcm(P - 1, Q - 1), E = 65537;

    // make sure 'E' is smaller than 'T', otherwise it is wrong
    assert(E < T);

    // start a loop in order to find 'D', it will check all values until it finds one which satisfies the inequation below
    while (D * E % T != 1)
        // increment 'D' in order to check the next value
        D++;

    // set the message as "U" turned to ASCII (85), then calculate 'C' as 'M ^ E mod N', the number is so big we have to use the function 'power()' above,
    // notice we must convert 'BigInt' to 'ulong' after it is done with the modulo
    M = 85, C = to!ulong(power(M, E) % N);
    // print all the number so that the user may see them
    writeln("P: ", P, "\nQ: ", Q, "\nN: ", N, "\nT: ", T, "\nE: ", E, "\nD: ", D, "\nM: ", M, "\nC: ", C);
    // tell the user we are now decrypting the message
    writeln("Decrypting:");
    // invert the RSA to obtain the original message by calculating 'C ^ D mod N', then print it, the number is so big we have to use the function 'power()' above,
    // notice we must convert 'BigInt' to 'ulong' after it is done with the modulo
    writeln(power(C, D) % N);
}
