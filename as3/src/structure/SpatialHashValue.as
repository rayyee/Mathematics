/**
 * User: Ray Yee
 * Date: 15/2/27
 * All rights reserved.
 */
package structure
{

    /**
     * Value stored in the spatial hash. Represents an AABB, a timestamp, and some internal cell coordinates.
     *
     * @author playchilla.com - License: free to use and if you like it - link back!
     */
    public class SpatialHashValue
    {

        public function SpatialHashValue( x1 : Number, y1 : Number, x2 : Number, y2 : Number )
        {
            update( x1, y1, x2, y2 );
        }

        public function update( x1 : Number, y1 : Number, x2 : Number, y2 : Number ) : void
        {
            this.x1 = x1;
            this.y1 = y1;
            this.x2 = x2;
            this.y2 = y2;
        }

        public function deltaMove( dx : Number, dy : Number ) : void
        {
            x1 += dx;
            y1 += dy;
            x2 += dx;
            y2 += dy;
        }

        /**
         * Excluded objects will not be found when searching the spatial hash (getOverlapping).
         */
        public function setExclude( exclude : Boolean ) : void
        { timeStamp = exclude ? uint.MAX_VALUE : 0; }

        /**
         * Exposed internally for performance reasons.
         */
        internal var x1 : Number;
        internal var x2 : Number;
        internal var y1 : Number;
        internal var y2 : Number;
        internal var cx1 : int = 0;
        internal var cx2 : int = 0;
        internal var cy1 : int = 0;
        internal var cy2 : int = 0;
        internal var timeStamp : uint = 0;
    }
}
