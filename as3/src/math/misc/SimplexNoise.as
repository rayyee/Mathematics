/**
 * User: Ray Yee
 * Date: 15/1/25
 * All rights reserved.
 */
package math.misc
{

    public class SimplexNoise
    {
        private static const perm : Vector.<int> = new <int>[
            151, 160, 137, 91, 90, 15,
            131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
            190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
            88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
            77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
            102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
            135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
            5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
            223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
            129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
            251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
            49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
            138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180
        ];

        private static function hash( i : int ) : int
        {
            return perm[i];
        }

        private static function grad( hash : int, x : Number ) : Number
        {
            var h : int = hash & 15;
            var grad : Number = 1.0 + (h & 7);
            if ( (h & 8) != 0 ) grad = -grad;
            return (grad * x);
        }

        private static function grad2d( hash : int, x : Number, y : Number ) : Number
        {
            var h : int = hash & 7;
            var u : Number = h < 4 ? x : y;
            var v : Number = h < 4 ? y : x;
            return ((h & 1) ? -u : u) + ((h & 2) ? -2.0 * v : 2.0 * v);
        }

        public static function noise1d( x : Number ) : Number
        {
            x = x % (perm.length - 1);

            var n0 : Number, n1 : Number;
            var i0 : int = Math.floor( x );
            var i1 : int = i0 + 1;

            var x0 : Number = x - i0;
            var x1 : Number = x0 - 1.0;

            var t0 : Number = 1.0 - x0 * x0;
            t0 *= t0;
            n0 = t0 * t0 * grad( hash( i0 ), x0 );

            var t1 : Number = 1.0 - x1 * x1;
            t1 *= t1;
            n1 = t1 * t1 * grad( hash( i1 ), x1 );

            return 0.395 * (n0 + n1);
        }

        public static function noise2d( x : Number, y : Number ) : Number
        {
            var n0 : Number, n1 : Number, n2 : Number;
            const F2 : Number = 0.366025403;  // F2 = 0.5*(sqrt(3.0)-1.0)
            const G2 : Number = 0.211324865;  // G2 = (3.0-sqrt(3.0))/6.0
            var s : Number = (x + y) * F2;
            var xs : Number = x + s;
            var ys : Number = y + s;
            var i : int = Math.floor( xs );
            var j : int = Math.floor( ys );

            var t : Number = Math.floor( i + j ) * G2;
            var X0 : Number = i - t;
            var Y0 : Number = j - t;
            var x0 : Number = x - X0;
            var y0 : Number = y - Y0;

            var i1 : int, j1 : int;
            if ( x0 > y0 )
            {
                i1 = 1;
                j1 = 0;
            }
            else
            {
                i1 = 0;
                j1 = 1;
            }

            var x1 : Number = x0 - i1 + G2;
            var y1 : Number = y0 - j1 + G2;
            var x2 : Number = x0 - 1.0 + 2.0 * G2;
            var y2 : Number = y0 - 1.0 + 2.0 * G2;

            var t0 : Number = 0.5 - x0 * x0 - y0 * y0;
            if ( t0 < 0.0 )
            {
                n0 = 0.0;
            }
            else
            {
                t0 *= t0;
                n0 = t0 * t0 * grad2d( hash( i + hash( j ) ), x0, y0 );
            }

            var t1 : Number = 0.5 - x1 * x1 - y1 * y1;
            if ( t1 < 0.0 )
            {
                n1 = 0.0;

            }
            else
            {
                t1 *= t1;
                n1 = t1 * t1 * grad2d( hash( i + i1 + hash( j + j1 ) ), x1, y1 );
            }

            var t2 : Number = 0.5 - x2 * x2 - y2 * y2;
            if ( t2 < 0.0 )
            {
                n2 = 0.0;
            }
            else
            {
                t2 *= t2;
                n2 = t2 * t2 * grad2d( hash( i + 1 + hash( j + 1 ) ), x2, y2 );
            }

            return 45.23065 * (n0 + n1 + n2);
        }
    }
}
