/*
 * Author: BaerMitUmlaut
 * Local PerFrameHandler during fast roping.
 *
 * Arguments:
 * 0: PFH arguments <ARRAY>
 * 1: PFH handle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_unit, _vehicle, _rope, _ropeIndex], 0] call ace_fastroping_fnc_fastRopeLocalPFH
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_arguments", "_pfhHandle"];
_arguments params ["_unit", "_vehicle", "_rope", "_ropeIndex"];
_rope params ["_attachmentPoint", "_ropeTop", "_ropeBottom", "_dummy", "_anchor", "_hook", "_occupied"];
private ["_vectorUp", "_vectorDir", "_origin"];

//Wait until the unit is actually outside of the helicopter
if (vehicle _unit != _unit) exitWith {};

//Start fast roping
if (animationState _unit != "ACE_slidingLoop") exitWith {
    _unit disableCollisionWith _dummy;
    _unit attachTo [_dummy, [0, 0, -0.5]];
    [_unit, "ACE_slidingLoop", 2] call EFUNC(common,doAnimation);
};

//End of fast rope
if (isNull attachedTo _unit) exitWith {
    if ((getPos _unit) select 2 > 1) then {
        [_unit, "ACE_freeFallStart", 2] call EFUNC(common,doAnimation);
        [_unit, "ACE_freeFallLoop", 1] call EFUNC(common,doAnimation);
    } else {
        [_unit, "", 2] call EFUNC(common,doAnimation);
    };
    _unit setVectorUp [0, 0, 1];

    [_pfhHandle] call CBA_fnc_removePerFrameHandler;
};
