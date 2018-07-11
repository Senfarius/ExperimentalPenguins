import it.gotoandplay.smartfoxserver.User

/**
 * The Room class stores the properties of each server room.
 * This class is used internally by the {@link SmartFoxClient} class; also, Room objects are returned by various methods and events of the SmartFoxServer API.
 * 
 * <b>NOTE</b>: in the provided examples, {@code room} always indicates a Room instance.
 * 
 * @version	3.0.0
 * 
 * @author	The gotoAndPlay() Team
 * 			{@link http://www.smartfoxserver.com}
 * 			{@link http://www.gotoandplay.it}
 */
class it.gotoandplay.smartfoxserver.Room
{

	private var id:Number
	private var name:String
	private var maxUsers:Number
	private var maxSpectators:Number
	private var temp:Boolean
	private var game:Boolean
	private var priv:Boolean
	private var limbo:Boolean
	private var updatable:Boolean
	private var description:String
	private var userCount:Number
	private var specCount:Number
	
	private var myPlayerIndex:Number
	
	private var userList:Object
	private var variables:Object
	
	/**
	 * Room contructor.
	 * 
	 * @param	id:				the room id.
	 * @param	name:			the room name.
	 * @param	maxUsers:		the maximum number of users that can join the room simultaneously.
	 * @param	maxSpectators:	the maximum number of spectators in the room (for game rooms only).
	 * @param	isTemp:			{@code true} if the room is temporary.
	 * @param	isGame:			{@code true} if the room is a "game room".
	 * @param	isPrivate:		{@code true} if the room is private (password protected).
	 * 
	 * @exclude
	 */
	public function Room(id, name, maxUsers, maxSpectators, isTemp, isGame, isPrivate)
	{
		this.id			= id
		this.name 		= name
		this.maxUsers 		= maxUsers
		this.maxSpectators	= maxSpectators
		this.temp 		= isTemp
		this.game 		= isGame
		this.priv 		= isPrivate
		this.limbo		= false
		
		this.updatable 		= false
		this.description 	= ""
		this.userCount 		= 0
		this.specCount		= 0
		
		this.userList		= new Object()
		this.variables		= new Array()		
	}
	
	/**
	 * Get the list of users currently inside the room.
	 * 
	 * @return	A object containing the {@link User} objects.
	 * 
	 * @example	<code>
	 * 			var users:Object = room.getUserList()
	 *			
	 *			for (var u:String in users)
	 *				trace(users[u].getName())
	 * 			</code>
	 * 
	 * @see		#getUser
	 * @see		User
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getUserList():Object
	{
		return this.userList
	}
	
	/**
	 * Retrieve a user currently in the room.
	 * 
	 * @param 	userId:	the user name ({@code String}) or the id ({@code Number}) of the user to retrieve.
	 * 
	 * @return	A {@link User} object.
	 * 
	 * @example	<code>
	 * 			var user:User = room.getUser("jack")
	 * 			</code>
	 * 
	 * @see		#getUserList
	 * @see		User
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getUser(userId):User
	{
		if (typeof userId == "number")
		{
			return this.userList[userId]
		}
		else if (typeof userId == "string")
		{
			for (var i in this.userList)
			{
				var u = this.userList[i]
	
				if (u.getName() == userId)
				{
					return u;
				}
			}
		}
	}
	
	/**
	 * Retrieve a Room Variable.
	 * 
	 * @param	varName:	the name of the variable to retrieve.
	 * 
	 * @return	The Room Variable's value.
	 * 
	 * @example	<code>
	 * 			var location:String = room.getVariable("location")
	 * 			</code>
	 * 
	 * @see		#getVariables
	 * @see		SmartFoxClient#setRoomVariables
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getVariable(varName:String)
	{
		return this.variables[varName]
	}
	
	/**
	 * Retrieve the list of all Room Variables.
	 * 
	 * @return	An object containing Room Variables' values, which can be retrieved by means of the variable name.
	 * 
	 * @example	<code>
	 * 			var roomVars:Object = room.getVariables()
	 * 			
	 * 			for (var v:String in roomVars)
	 * 				trace("Name:" + v + " | Value:" + roomVars[v])
	 * 			</code>
	 * 
	 * @see		#getVariable
	 * @see		SmartFoxClient#setRoomVariables
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getVariables():Object
	{
		return this.variables
	}
	
	/**
	 * Get the name of the room.
	 * 
	 * @return	The name of the room.
	 * 
	 * @example	<code>
	 * 			trace("Room name:" + room.getName())
	 * 			</code>
	 * 
	 * @see		#getId
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getName():String
	{
		return this.name
	}
	
	/**
	 * Get the id of the room.
	 * 
	 * @return	The id of the room.
	 * 
	 * @example	<code>
	 * 			trace("Room id:" + room.getId())
	 * 			</code>
	 * 
	 * @see		#getName
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getId():Number
	{
		return this.id
	}
	
	/**
	 * A boolean flag indicating if the room is dynamic/temporary.
	 * This is always true for rooms created at runtime on client-side.
	 * 
	 * @return	{@code true} if the room is a dynamic/temporary room.
	 * 
	 * @example	<code>
	 * 			if (room.isTemp)
	 * 				trace("Room is temporary")
	 * 			</code>
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function isTemp():Boolean
	{
		return this.temp
	}
	
	/**
	 * A boolean flag indicating if the room is a "game room".
	 * 
	 * @return	{@code true} if the room is a "game room".
	 * 
	 * @example	<code>
	 * 			if (room.isGame)
	 * 				trace("This is a game room")
	 * 			</code>
	 * 
	 * @see		#isLimbo
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function isGame():Boolean
	{
		return this.game
	}
	
	/**
	 * A boolean flag indicating if the room is private (password protected).
	 * 
	 * @return	{@code true} if the room is private.
	 * 
	 * @example	<code>
	 * 			if (room.isPrivate)
	 * 				trace("Password required for this room")
	 * 			</code>
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function isPrivate():Boolean
	{
		return this.priv
	}
	
	/**
	 * Retrieve the number of users currently inside the room.
	 * 
	 * @return	The number of users in the room.
	 * 
	 * @example	<code>
	 * 			var usersNum:Number = room.getUserCount()
	 * 			trace("There are " + usersNum + " users in the room")
	 * 			</code>
	 * 
	 * @see		#getSpectatorCount
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getUserCount():Number
	{
		return this.userCount
	}
	
	/**
	 * Retrieve the number of spectators currently inside the room.
	 * 
	 * @return	The number of spectators in the room.
	 * 
	 * @example	<code>
	 * 			var specsNum:Number = room.getSpectatorCount()
	 * 			trace("There are " + specsNum + " spectators in the room")
	 * 			</code>
	 * 
	 * @see		#getUserCount
	 * 
	 * @version	SmartFoxServer Basic / Pro
	 */
	public function getSpectatorCount():Number
	{
		return this.specCount
	}
	
	/**
	 * Retrieve the maximum number of users that can join the room.
	 * 
	 * @return	The maximum number of users that can join the room.
	 * 
	 * @example	<code>
	 * 			trace("Max users allowed to join the room: " + room.getMaxUsers())
	 * 			</code>
	 * 
	 * @see		#getMaxSpectators
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getMaxUsers():Number
	{
		return this.maxUsers
	}
	
	/**
	 * Retrieve the maximum number of spectators that can join the room.
	 * Spectators can exist in game rooms only.
	 * 
	 * @return	The maximum number of spectators that can join the room.
	 * 
	 * @example	<code>
	 * 			if (room.isGame)
	 * 				trace("Max spectators allowed to join the room: " + room.getMaxSpectators())
	 * 			</code>
	 * 
	 * @see		#getMaxUsers
	 * 
	 * @version	SmartFoxServer Basic / Pro
	 */
	public function getMaxSpectators():Number
	{
		return this.maxSpectators
	}
	
	/**
	 * Set the myPlayerId property.
	 * Each room where the current client is connected contains a myPlayerId (if the room is a gameRoom).
	 * myPlayerId == -1 ... user is a spectator
	 * myPlayerId  > 0  ...	user is a player
	 * 
	 * @param	id:	the myPlayerId value.
	 * 
	 * @exclude
	 */
	public function setMyPlayerIndex(id:Number):Void
	{
		this.myPlayerIndex = id
	}
	
	/**
	 * Retrieve the player id for the current user in the room.
	 * This id is 1-based (player 1, player 2, etc.), but if the user is a spectator its value is -1.
	 * 
	 * @return	The player id for the current user.
	 * 
	 * @example	<code>
	 * 			if (room.isGame)
	 * 				trace("My player id in this room: " + room.getMyPlayerIndex())
	 * 			</code>
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function getMyPlayerIndex():Number
	{
		return this.myPlayerIndex
	}
	
	/**
	 * Set the {@link #isLimbo} property.
	 * 
	 * @param	b:	{@code true} if the room is a "limbo room".
	 * 
	 * @exclude
	 */
	public function setIsLimbo(b:Boolean):Void
	{
		this.limbo = b
	}
	
	/**
	 * A boolean flag indicating if the room is in "limbo mode".
	 * 
	 * @return	{@code true} if the room is in "limbo mode".
	 * 
	 * @example	<code>
	 * 			if (room.isLimbo)
	 * 				trace("This is a limbo room")
	 * 			</code>
	 * 
	 * @see		#isGame
	 * 
	 * @version	SmartFoxServer Lite / Basic / Pro
	 */
	public function isLimbo():Boolean
	{
		return this.limbo
	}
}