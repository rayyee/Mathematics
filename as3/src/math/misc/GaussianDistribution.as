/**
 * User: Ray Yee
 * Date: 15/2/2
 * All rights reserved.
 */
package math.misc
{

    public class GaussianDistribution
    {
        private static const c0 : Number = 2.515517;
        private static const c1 : Number = 0.802853;
        private static const c2 : Number = 0.010328;
        private static const d1 : Number = 1.432788;
        private static const d2 : Number = 0.189269;
        private static const d3 : Number = 0.001308;

        /**
         * 正态分布的随机数
         * a控制波形的顶点, b控制波形的y轴扁度
         * @param a    如a是100, 即随机出100的机率会大于99,98,101,102 然后远离100的逐渐递减
         *    ^f(x), probability
         *    |
         *    |
         *    |                       100
         *    |                     99   101
         *    |                    98     102
         *    |              97                  103
         *    |         96                               104
         *    |...                                                 ...
         *    ------------------------------------------------------------> x
         * @param b    如b是2, 即随机出[98-102]之间的数字概率最大 (注意这里的b是方差，等于标准差的平方)
         * @return
         */
        public static function next( a : Number, b : Number ) : Number
        {
            var f : Number = 0;
            var w : Number;
            var r : Number = Math.random();
            if ( r <= 0.5 ) w = r;
            else w = 1 - r;
            if ( (r - 0.5) > 0 ) f = 1;
            else if ( (r - 0.5) < 0 ) f = -1;
            var y : Number = Math.sqrt( (-2) * Math.log( w ) );
            var x : Number = f * (y - (c0 + c1 * y + c2 * y * y) / (1 + d1 * y + d2 * y * y + d3 * y * y * y));
            var z : Number = a + x * Math.sqrt( b );
            return (z);
        }
    }
}
