class com.greensock.core.PropTween
{
    var target, property, start, change, name, isPlugin, nextNode, priority;
    function PropTween(target, property, start, change, name, isPlugin, nextNode, priority)
    {
        this.target = target;
        this.property = property;
        this.start = start;
        this.change = change;
        this.name = name;
        this.isPlugin = isPlugin;
        if (nextNode)
        {
            nextNode.prevNode = this;
            this.nextNode = nextNode;
        } // end if
        this.priority = priority || 0;
    } // End of the function
} // End of Class
