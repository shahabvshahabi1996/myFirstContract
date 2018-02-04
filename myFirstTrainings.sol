pragma solidity ^0.4.0;

import "./safeMath.sol";


contract Coin {
    using SafeMath for uint;
    mapping(address => uint) private _balanceOF;
    address private _owner;
    uint private constant TOTAL_SUPPLY = 1000;
    event Sent(address _from, address _to, uint _value);

    function Coin() public {
        _owner = msg.sender; 
        _balanceOF[msg.sender] = TOTAL_SUPPLY; 
    }

    function transferTO(address _to, uint _value) public returns(bool success) {
        if (_owner == msg.sender) {
            if (balanceOf(msg.sender) >= _value && _value > 0 && balanceOf(msg.sender) > 0) {
                _balanceOF[msg.sender].sub(_value);
                _balanceOF[_to].add(_value);
                Sent(msg.sender, _to, _value);
                return true;
            }

            return false;
        }
    }

    function transferFrom(address _from, address _to, uint _value) public returns(bool success) {
        if (balanceOf(_from) >= _value && _value > 0 && balanceOf(_from) > 0) {
            _balanceOF[_from].sub(_value);
            _balanceOF[_to].add(_value);
            Sent(_from, _to, _value);
            return true;
        }

        return false;
    }

    function balanceOf(address _address) public returns(uint value) {
        return _balanceOF[_address];
    }
    
    function balanceOfOwner() public returns(uint value) {
        return _balanceOF[_owner];
    }
    
    function distOwnerBalance() public returns(bool success) {
        _balanceOF[_owner] = 0;
        return true;
    }
}