/**
 * User: Ray Yee
 * Date: 15/2/27
 * All rights reserved.
 */
package math.geometry
{

    final public class Vector2
    {
        private static const _RadsToDeg:Number = 180 / Math.PI;
        public static const Epsilon : Number = 0.0000001;
        public static const EpsilonSqrt : Number = Epsilon * Epsilon;

        private var _x : Number;
        private var _y : Number;

        public function get x() : Number { return _x; }

        public function get y() : Number { return _y; }

        public function Vector2( x : Number = 0, y : Number = 0 )
        {
            _x = x;
            _y = y;
        }

        public function clone() : Vector2
        { return new Vector2( _x, _y ); }

        /**
         * Normalize
         */
        public function normalize() : Vector2
        {
            const nf : Number = 1 / Math.sqrt( _x * _x + _y * _y );
            return new Vector2( _x * nf, _y * nf );
        }

        /**
         * Basic arithmetic about add, sub, mul and div
         */
        public function add( pos : Vector2 ) : Vector2
        { return new Vector2( _x + pos._x, _y + pos._y ); }

        public function addXY( x : Number, y : Number ) : Vector2
        { return new Vector2( _x + x, _y + y ); }

        public function sub( pos : Vector2 ) : Vector2
        { return new Vector2( _x - pos._x, _y - pos._y ); }

        public function subXY( x : Number, y : Number ) : Vector2
        { return new Vector2( _x - x, _y - y ); }

        public function mul( vec : Vector2 ) : Vector2
        { return new Vector2( _x * vec._x, _y * vec._y ); }

        public function mulXY( x : Number, y : Number ) : Vector2
        { return new Vector2( _x * x, _y * y ); }

        public function div( vec : Vector2 ) : Vector2
        { return new Vector2( _x / vec._x, _y / vec._y ); }

        public function divXY( x : Number, y : Number ) : Vector2
        { return new Vector2( _x / x, _y / y ); }

        /**
         * Distance
         */
        public function length() : Number
        { return Math.sqrt( _x * _x + _y * _y ); }

        public function lengthSqrt() : Number
        { return _x * _x + _y * _y; }

        public function distance( vec : Vector2 ) : Number
        {
            const xd : Number = _x - vec._x;
            const yd : Number = _y - vec._y;
            return Math.sqrt( xd * xd + yd * yd );
        }

        public function distanceXY( x : Number, y : Number ) : Number
        {
            const xd : Number = _x - x;
            const yd : Number = _y - y;
            return Math.sqrt( xd * xd + yd * yd );
        }

        public function distanceSqrt( vec : Vector2 ) : Number
        {
            const xd : Number = _x - vec._x;
            const yd : Number = _y - vec._y;
            return xd * xd + yd * yd;
        }

        public function distanceXYSqrt( x : Number, y : Number ) : Number
        {
            const xd : Number = _x - x;
            const yd : Number = _y - y;
            return xd * xd + yd * yd;
        }

        /**
         * Queries.
         */
        public function equals( vec : Vector2 ) : Boolean
        { return _x == vec._x && _y == vec._y; }

        public function equalsXY( x : Number, y : Number ) : Boolean { return _x == x && _y == y; }

        public function isNormalized() : Boolean { return Math.abs( (_x * _x + _y * _y) - 1 ) < Vector2.EpsilonSqrt; }

        public function isZero() : Boolean { return _x == 0 && _y == 0; }

        public function isNear( vec2 : Vector2 ) : Boolean { return distanceSqrt( vec2 ) < Vector2.EpsilonSqrt; }

        public function isNearXY( x : Number, y : Number ) : Boolean { return distanceXYSqrt( x, y ) < Vector2.EpsilonSqrt; }

        public function isWithin( vec2 : Vector2, epsilon : Number ) : Boolean { return distanceSqrt( vec2 ) < epsilon * epsilon; }

        public function isWithinXY( x : Number, y : Number, epsilon : Number ) : Boolean { return distanceXYSqrt( x, y ) < epsilon * epsilon; }

        public function isValid() : Boolean { return !isNaN( _x ) && !isNaN( _y ) && isFinite( _x ) && isFinite( _y ); }

        public function getDegrees() : Number { return getRads() * _RadsToDeg; }

        public function getRads() : Number { return Math.atan2( _y, _x ); }

        public function getRadsBetween( vec : Vector2 ) : Number { return Math.atan2( x - vec.x, y - vec.y ); }

        /**
         * Dot product
         */
        public function dot( vec : Vector2 ) : Number
        { return _x * vec._x + _y * vec._y; }

        public function dotXY( x : Number, y : Number ) : Number
        { return _x * x + _y * y; }

        /**
         * Cross determinant
         */
        public function crossDet( vec : Vector2 ) : Number
        { return _x * vec._y - _y * vec._x; }

        public function crossDetXY( x : Number, y : Number ) : Number { return _x * y - _y * x; }

        /**
         * Rotate
         */
        public function rotate( rads : Number ) : Vector2
        {
            const s : Number = Math.sin( rads );
            const c : Number = Math.cos( rads );
            return new Vector2( _x * c - _y * s, _x * s + _y * c );
        }

        public function normalRight() : Vector2
        { return new Vector2( -_y, _x ); }

        public function normalLeft() : Vector2
        { return new Vector2( _y, -_x ); }

        public function negate() : Vector2
        { return new Vector2( -_x, -_y ); }

        /**
         * Spinor rotation
         */
        public function rotateSpinorXY( x : Number, y : Number ) : Vector2
        { return new Vector2( _x * x - _y * y, _x * y + _y * x ); }

        public function rotateSpinor( vec : Vector2 ) : Vector2
        { return new Vector2( _x * vec._x - _y * vec._y, _x * vec._y + _y * vec._x ); }

        public function spinorBetween( vec : Vector2 ) : Vector2
        {
            const d : Number = lengthSqrt();
            const r : Number = (vec._x * _x + vec._y * _y) / d;
            const i : Number = (vec._y * _x - vec._x * _y) / d;
            return new Vector2( r, i );
        }

        /**
         * Scale
         */
        public function scale( s : Number ) : Vector2
        { return new Vector2( _x * s, _y * s ); }

        /**
         * Lerp
         */
        public function lerp( to : Vector2, t : Number ) : Vector2
        { return new Vector2( _x + t * (to._x - _x), _y + t * (to._y - _y) ); }

        public function slerp( vec : Vector2, t : Number ) : Vector2
        {
            const cosTheta : Number = dot( vec );
            const theta : Number = Math.acos( cosTheta );
            const sinTheta : Number = Math.sin( theta );
            if ( sinTheta <= Vector2.Epsilon )
                return vec.clone();
            const w1 : Number = Math.sin( (1 - t) * theta ) / sinTheta;
            const w2 : Number = Math.sin( t * theta ) / sinTheta;
            return scale( w1 ).add( vec.scale( w2 ) );
        }

        /**
         * Reflect
         */
        public function reflect( normal : Vector2 ) : Vector2
        {
            const d : Number = 2 * (_x * normal._x + _y * normal._y);
            return new Vector2( _x - d * normal._x, _y - d * normal._y );
        }
    }
}
