/**
 * User: Ray Yee
 * Date: 15/2/27
 * All rights reserved.
 */
package structure
{

    import flash.utils.Dictionary;

    /**
     * A simple 2D spatial hashing class from the Playchilla Physics Engine.
     *
     * @author playchilla.com - License: free to use and if you like it - link back!
     */
    public class SpatialHash
    {
        public function SpatialHash( cellSize : Number, maxBuckets : uint )
        {
            _cellSize = cellSize;
            _maxBuckets = maxBuckets;
        }

        public function add( shv : SpatialHashValue ) : void
        {
            shv.cx1 = shv.x1 / _cellSize;
            shv.cy1 = shv.y1 / _cellSize;
            shv.cx2 = shv.x2 / _cellSize;
            shv.cy2 = shv.y2 / _cellSize;
            for ( var cy : int = shv.cy1; cy <= shv.cy2; ++cy )
                for ( var cx : int = shv.cx1; cx <= shv.cx2; ++cx )
                    _addToBucket( shv, cx, cy );
        }

        public function remove( shv : SpatialHashValue ) : void
        {
            for ( var cy : int = shv.cy1; cy <= shv.cy2; ++cy )
                for ( var cx : int = shv.cx1; cx <= shv.cx2; ++cx )
                    _removeFromBucket( shv, cx, cy );
        }

        public function update( shv : SpatialHashValue ) : void
        {
            const newCx1 : int = shv.x1 / _cellSize;
            const newCy1 : int = shv.y1 / _cellSize;
            const newCx2 : int = shv.x2 / _cellSize;
            const newCy2 : int = shv.y2 / _cellSize;

            // add new
            for ( var cy : int = newCy1; cy <= newCy2; ++cy )
                for ( var cx : int = newCx1; cx <= newCx2; ++cx )
                    if ( cx < shv.cx1 || cx > shv.cx2 || cy < shv.cy1 || cy > shv.cy2 )
                        _addToBucket( shv, cx, cy );

            // remove old
            for ( cy = shv.cy1; cy <= shv.cy2; ++cy )
                for ( cx = shv.cx1; cx <= shv.cx2; ++cx )
                    if ( cx < newCx1 || cx > newCx2 || cy < newCy1 || cy > newCy2 )
                        _removeFromBucket( shv, cx, cy );

            shv.cx1 = newCx1;
            shv.cy1 = newCy1;
            shv.cx2 = newCx2;
            shv.cy2 = newCy2;
        }

        public function getOverlapping( test : SpatialHashValue ) : Vector.<SpatialHashValue>
        {
            const result : Vector.<SpatialHashValue> = new Vector.<SpatialHashValue>;
            const cx1 : int = test.x1 / _cellSize;
            const cy1 : int = test.y1 / _cellSize;
            const cx2 : int = test.x2 / _cellSize;
            const cy2 : int = test.y2 / _cellSize;
            for ( var cy : int = cy1; cy <= cy2; ++cy )
                for ( var cx : int = cx1; cx <= cx2; ++cx )
                {
                    const bucket : Vector.<SpatialHashValue> = _hash[_getKey( cx, cy )];
                    if ( bucket == null ) continue;
                    for each ( var b : SpatialHashValue in bucket )
                    {
                        if ( b.timeStamp >= _timeStamp )
                            continue;
                        b.timeStamp = _timeStamp;
                        if ( test.x1 < b.x2 &&
                             test.x2 > b.x1 &&
                             test.y1 < b.y2 &&
                             test.y2 > b.y1 )
                            result.push( b );
                    }
                }
            ++_timeStamp;
            return result;
        }

        private function _addToBucket( shv : SpatialHashValue, cx : int, cy : int ) : void
        {
            const key : uint = _getKey( cx, cy );
            var bucket : Vector.<SpatialHashValue> = _hash[key];
            if ( bucket == null )
            {
                bucket = new Vector.<SpatialHashValue>();
                _hash[key] = bucket;
            }
            bucket.push( shv );
        }

        private function _removeFromBucket( shv : SpatialHashValue, cx : int, cy : int ) : void
        {
            const key : uint = _getKey( cx, cy );
            const bucket : Vector.<SpatialHashValue> = _hash[key];
            if ( bucket == null ) return;
            const size : int = bucket.length;
            for ( var i : int = 0; i < size; ++i )
            {
                const hashValue : SpatialHashValue = bucket[i];
                if ( hashValue != shv ) continue;
                if ( i == size - 1 )
                    bucket.pop();
                else
                    bucket[i] = bucket.pop();
                break;
            }
            if ( bucket.length == 0 )
                delete _hash[key];
        }

        private function _getKey( cx : int, cy : int ) : uint
        {
            // prime numbers from http://code.google.com/p/chipmunk-physics/source/browse/trunk/src/cpSpaceHash.c
            return (cx * 1640531513 ^ cy * 2654435789) % _maxBuckets;
        }

        private var _cellSize : Number;
        private var _maxBuckets : uint;
        private var _timeStamp : uint = 1;
        private const _hash : Dictionary = new Dictionary;
    }
}
