class com.clubpenguin.math.MathHelper
{
    function MathHelper()
    {
    } // End of the function
    static function getRandomNumberInRange(min, max)
    {
        return (Math.floor(Math.random() * (max - min)) + min);
    } // End of the function
    static function getAngleBetweenCoordinates(x1, y1, x2, y2)
    {
        var _loc3 = x2 - x1;
        var _loc2 = y2 - y1;
        var _loc1 = int(Math.atan2(_loc2, _loc3) * 57.295780 - 90);
        if (_loc1 < 0)
        {
            return (_loc1 + 360);
        }
        else
        {
            return (_loc1);
        } // end else if
    } // End of the function
    static function getAngleBetweenPoints(p1, p2)
    {
        return (com.clubpenguin.math.MathHelper.getAngleBetweenCoordinates(p1.x, p1.y, p2.x, p2.y));
    } // End of the function
    static function get8DirectionByAngle(angle)
    {
        var _loc1 = Math.round(angle / 45) + 1;
        if (_loc1 > 8)
        {
            _loc1 = 1;
        } // end if
        return (_loc1);
    } // End of the function
} // End of Class
