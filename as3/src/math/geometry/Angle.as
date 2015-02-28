/**
 * User: Ray Yee
 * Date: 15/2/16
 * All rights reserved.
 */
package math.geometry
{

    final public class Angle
    {
        private static const R2D : Number = 180 / Math.PI;
        private static const D2R : Number = Math.PI / 180;

        public static function radian2Degree( radian : Number ) : Number
        {
            return radian * R2D;
        }

        public static function degree2Radian( angleDegree : Number ) : Number
        {
            return angleDegree * D2R;
        }

        public static function vecAngle( x1 : Number, y1 : Number, x2 : Number, y2 : Number ) : Number
        {
//            return Math.atan2( y2 - y1, x2 - x1 ) / (Math.PI / 180);
            return Math.atan2( y2 - y1, x2 - x1 ) * R2D;
        }

        public static function normalize( angleDegree : Number ) : Number
        {
            angleDegree %= 360;
            return (angleDegree < 0) ? angleDegree + 360 : angleDegree;
        }

        public static function distance( a : Number, b : Number ) : Number
        {
            a = normalize( a );
            b = normalize( b );
            const diff : Number = Math.abs( a - b );
            var dist : Number = (diff > 180) ? 360 - diff : diff;
            if ( b != normalize( a + dist ) )
            {
                dist *= -1;
            }
            return dist;
        }

        private var m_angleDegree : Number = 0.;

        public function Angle( v : Number )
        {
            m_angleDegree = v;
        }

        public function rotate( v : Number ) : void
        {
            m_angleDegree += v;
        }

        public function getDegree() : Number
        {
            return m_angleDegree;
        }
    }
}
