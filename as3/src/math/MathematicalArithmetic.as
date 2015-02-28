/**
 * User: Ray Yee
 * Date: 15/2/1
 * All rights reserved.
 */
package math
{

    public class MathematicalArithmetic
    {

        /**
         * 符号，即取x的符号位
         * @param x
         * @return
         */
        public static function sign( x : Number ) : Number
        {
            return x < 0 ? -1 : (x > 0 ? 1 : 0);
        }

        /**
         * 碎片，即取x的小数部分
         * @param x
         * @return
         */
        public static function fract( x : Number ) : Number
        {
            return x - (x >> 0);
        }

        /**
         * 插值，又叫混合(mix)，[a, b]2个值用t来混合
         * @param a
         * @param b
         * @param t
         * @return
         */
        public static function lerp( a : Number, b : Number, t : Number ) : Number
        {
            return a * ( 1 - t ) + b * t;
        }

        /**
         * 饱和，把值夹在[0~1]之间，即x<0时为0，x>1时为1
         * = clamp(x, 0., 1.)
         * @param x
         * @return
         */
        public static function saturate( x : Number ) : Number
        {
            return clamp( x, 0., 1. );
        }

        /**
         * 夹子，同饱和，但可以自定义范围
         * @param v
         * @param min
         * @param max
         * @return
         */
        public static function clamp( v : Number, min : Number, max : Number ) : Number
        {
            return v > min ? (v < max ? v : max) : min;
//            return Math.min( Math.max( v, min ), max );
        }

        /**
         * 安全夹子，范围值确保从小到大，即a<b
         * @param v
         * @param a
         * @param b
         * @return
         */
        public static function clampSafely( v : Number, a : Number, b : Number ) : Number
        {
            if ( a == b ) return a;
            var min : Number = a < b ? a : b;
            var max : Number = min == a ? b : a;
            return v > min ? (v < max ? v : max) : min;
//            return Math.min( Math.max( v, min ), max );
        }

        /**
         * 标准，把在[a~b]空间的x标准化到[0~1]
         * @param x
         * @param a
         * @param b
         * @return
         */
        public static function norm( x : Number, a : Number, b : Number ) : Number
        {
            return ( x - a ) / ( b - a );
        }

        /**
         * 映射，把[a~b]空间的x映射到[x~y]空间
         * @param v
         * @param a
         * @param b
         * @param x
         * @param y
         * @return
         */
        public static function map( v : Number, a : Number, b : Number, x : Number, y : Number ) : Number
        {
            return x + ( y - x ) * ( ( v - a ) / ( b - a ) );
        }

        /**
         * Step，x小于边缘就是0，否则就是1，图形上就像是台阶
         * @param edge
         * @param x
         * @return
         */
        public static function step( edge : Number, x : Number ) : Number
        {
            return x < edge ? 0. : 1.;
        }

        /**
         * smooth step, 同step, 平滑的过度
         * @param edge0
         * @param edge1
         * @param x
         * @return
         */
        public static function smoothStep( edge0 : Number, edge1 : Number, x : Number ) : Number
        {
            x = norm( x, edge0, edge1 );
            return x * x * x * ( x * ( x * 6 - 15 ) + 10 );
        }

        /**
         * polynomial smooth min, [a, b]平滑的取最小值
         * @param a
         * @param b
         * @param k
         * @return
         */
        public static function smoothMin( a : Number, b : Number, k : Number ) : Number
        {
            var h : Number = saturate( .5 + .5 * (b - a) / k );
//            var h : Number = clamp( .5 + .5 * (b - a) / k, .0, 1. );
            return lerp( b, a, h ) - k * h * (1. - h);
        }
    }
}
