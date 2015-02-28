/**
 * User: Ray Yee
 * Date: 15/2/13
 * All rights reserved.
 */
package math.misc
{

    final public class NoiseOffset
    {
        private var m_offset:Number;

        public function NoiseOffset(seed:Number = 0.0)
        {
            m_offset = seed;
        }

        [Inline]
        public function next() : Number
        {
            m_offset += .01;
            return m_offset;
        }
        
        [Inline]
        public function fastNext(  ) : Number
        {
            m_offset += .1;
            return m_offset;
        }
        
        [Inline]
        public function snailNext (  ) : Number
        {
            m_offset += 0.001;
            return m_offset;
        }
    }
}
