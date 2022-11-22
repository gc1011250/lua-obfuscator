local Opcode = {
	[1] = "ABC",
	[2] = "AsBx",
	[3] = "ABx",
	[4] = "ABC",
	[5] = "ABC",
	[6] = "ABx",
	[7] = "ABC",
	[8] = "ABC",
	[9] = "ABC",
	[10] = "ABC",
	[11] = "ABC",
	[12] = "ABx",
	[13] = "ABC",
	[14] = "ABC",
	[15] = "ABC",
	[16] = "ABx",
	[17] = "ABC",
	[18] = "ABC",
	[19] = "ABC",
	[20] = "ABC",
	[21] = "ABC",
	[22] = "ABC",
	[23] = "ABC",
	[24] = "ABC",
	[25] = "ABC",
	[26] = "ABC",
	[27] = "ABC",
	[28] = "ABC",
	[29] = "ABC",
	[30] = "ABC",
	[31] = "ABC",
	[32] = "ABC",
	[36] = "ABC",
	[37] = "ABC",
	[33] = "AsBx",
	[34] = "AsBx",
	[35] = "ABC",
	[0] = "ABC"
}

local Opmode ={
	[1] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[2] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[3] = {
		["c"] = "OpArgN",
		["b"] = "OpArgK"
	},
	[4] = {
		["c"] = "OpArgK",
		["b"] = "OpArgR"
	},
	[5] = {
		["c"] = "OpArgN",
		["b"] = "OpArgU"
	},
	[6] = {
		["c"] = "OpArgN",
		["b"] = "OpArgU"
	},
	[7] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[8] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[9] = {
		["c"] = "OpArgN",
		["b"] = "OpArgU"
	},
	[10] = {
		["c"] = "OpArgN",
		["b"] = "OpArgU"
	},
	[11] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[12] = {
		["c"] = "OpArgN",
		["b"] = "OpArgK"
	},
	[13] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[14] = {
		["c"] = "OpArgR",
		["b"] = "OpArgR"
	},
	[15] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[16] = {
		["c"] = "OpArgN",
		["b"] = "OpArgK"
	},
	[17] = {
		["c"] = "OpArgU",
		["b"] = "OpArgR"
	},
	[18] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[19] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[20] = {
		["c"] = "OpArgU",
		["b"] = "OpArgN"
	},
	[21] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[22] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[23] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[24] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[25] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[26] = {
		["c"] = "OpArgU",
		["b"] = "OpArgU"
	},
	[27] = {
		["c"] = "OpArgU",
		["b"] = "OpArgU"
	},
	[28] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[29] = {
		["c"] = "OpArgK",
		["b"] = "OpArgK"
	},
	[30] = {
		["c"] = "OpArgU",
		["b"] = "OpArgR"
	},
	[31] = {
		["c"] = "OpArgU",
		["b"] = "OpArgU"
	},
	[32] = {
		["c"] = "OpArgN",
		["b"] = "OpArgN"
	},
	[36] = {
		["c"] = "OpArgU",
		["b"] = "OpArgU"
	},
	[37] = {
		["c"] = "OpArgU",
		["b"] = "OpArgU"
	},
	[33] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[34] = {
		["c"] = "OpArgN",
		["b"] = "OpArgR"
	},
	[35] = {
		["c"] = "OpArgN",
		["b"] = "OpArgU"
	},
	[0] = {
		["c"] = "OpArgK",
		["b"] = "OpArgR"
	}
}


        local Select	= select;
        local Byte		= string.byte;
        local Sub		= string.sub;
        
        
        
        local function gBit(Bit, Start, End)
            if End then 
                local Res	= (Bit / 2 ^ (Start - 1)) % 2 ^ ((End - 1) - (Start - 1) + 1);
        
                return Res - Res % 1;
            else
                local Plc = 2 ^ (Start - 1);
        
                if (Bit % (Plc + Plc) >= Plc) then
                    return 1;
                else
                    return 0;
                end;
            end;
        end;
        
        local function GetMeaning(ByteString)
            local Pos	= 1;
            local gSizet;
            local gInt;
        
            local function gBits8() 
                local F	= Byte(ByteString, Pos, Pos);
        
                Pos	= Pos + 1;
        
                return F;
            end;
        
            local function gBits32()
                local W, X, Y, Z	= Byte(ByteString, Pos, Pos + 3);
        
                Pos	= Pos + 4;
        
                return (Z * 16777216) + (Y * 65536) + (X * 256) + W;
            end;
        
            local function gBits64()
                return gBits32() * 4294967296 + gBits32();
            end;
        
            local function gFloat()
                local Left = gBits32();
                local Right = gBits32();
                local IsNormal = 1
                local Mantissa = (gBit(Right, 1, 20) * (2 ^ 32))
                                + Left;
        
                local Exponent = gBit(Right, 21, 31);
                local Sign = ((-1) ^ gBit(Right, 32));
        
                if (Exponent == 0) then
                    if (Mantissa == 0) then
                        return Sign * 0 -- +-0
                    else
                        Exponent = 1
                        IsNormal = 0
                    end
                elseif (Exponent == 2047) then
                    if (Mantissa == 0) then
                        return Sign * (1 / 0) -- +-Inf
                    else
                        return Sign * (0 / 0) -- +-Q/Nan
                    end
                end
        
                -- sign * 2**e-1023 * isNormal.mantissa
                return math.ldexp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)))
            end;
        
            local function gString(Len)
                local Str;
        
                if Len then
                    Str	= Sub(ByteString, Pos, Pos + Len - 1);
        
                    Pos = Pos + Len;
                else
                    Len = gSizet();
        
                    if (Len == 0) then return; end;
        
                    Str	= Sub(ByteString, Pos, Pos + Len - 1);
        
                    Pos = Pos + Len;
                end;
        
                return Str;
            end;
        
            local function ChunkDecode()
                local Instr	= {};
                local Const	= {};
                local Proto	= {};

                gString();
                gInt();
                gInt();
                
                local Chunk = {
Instr,
Proto,
Const,
};
                
                Chunk[4] = gBits8();
                Chunk[28] = gBits8();
                gBits8();
                gBits8();

                local ConstantReferences = {};    
    

		for Idx = 1, gInt() do 
			local Data	= gBits32();
			local Opco = gBit(Data,27,32);
			local Type	= Opcode[Opco];
			local Mode  = Opmode[Opco];

			local Inst	= {
				[6]	= Opco;
				Value	= Data;
			};
	
			if Type == "ABC" then
				Inst[1] = gBit(Data,10,17);
				Inst[2] = gBit(Data,1,9);
				Inst[3] = gBit(Data,18,26);
			elseif Type == "ABx" then
				Inst[1] = gBit(Data,19,26);
				Inst[2] = gBit(Data,1,18);
			elseif Type == "AsBx" then
				Inst[1] = gBit(Data,19,26);
				Inst[2] = gBit(Data,1,18) - 131071;
			end

			
			do 
				
				if Opco == 30 or Opco == 17 then 
					Inst[3] = Inst[3] == 0;
				end

				
				if Opco == 28 or Opco == 22 or Opco == 29 then  
					Inst[1] = Inst[1] ~= 0;
				end 

				
				if Mode.b == 'OpArgK' then
					Inst[3] = Inst[3] or false;
					if Inst[2] >= 256 then 
						local Cons = Inst[2] - 256;
						Inst[4] = Cons;

						local ReferenceData = ConstantReferences[Cons];
						if not ReferenceData then 
							ReferenceData = {};
							ConstantReferences[Cons] = ReferenceData;
						end

						ReferenceData[#ReferenceData + 1] = {Inst = Inst, Register = 4}
					end
				end 

		
				if Mode.c == 'OpArgK' then
					Inst[4] = Inst[4] or false
					if Inst[3] >= 256 then 
						local Cons = Inst[3] - 256;
						Inst[5] = Cons;

						local ReferenceData = ConstantReferences[Cons];
						if not ReferenceData then 
							ReferenceData = {};
							ConstantReferences[Cons] = ReferenceData;
						end

						ReferenceData[#ReferenceData + 1] = {Inst = Inst, Register = 5}
					end
				end 
			end

			Instr[Idx]	= Inst;
		end;
        
        do
            for Idx = 1, gInt() do
                Proto[Idx - 1]	= ChunkDecode();
            end;
        end
        for Idx = 1, gInt() do
			local Type	= gBits8();
			local Cons;

			if (Type == 1) then
				Cons	= (gBits8() ~= 0);
			elseif (Type == 3) then
				Cons	= gFloat();
			elseif (Type == 4) then
				Cons	= Sub(gString(), 1, -2);
			end;

			
			local Refs = ConstantReferences[Idx - 1];
			if Refs then 
				for i = 1, #Refs do
					Refs[i].Inst[Refs[i].Register] = Cons
				end 
			end

			
			Const[Idx - 1]	= Cons;
		end;
        
    
    gBits32();
    gBits32();
    gBits32();
    
    return Chunk;
end

do
    assert(gString(5) == "\27Aqua", "Aqua bytecode expected.");
    assert(gBits8() == 0x69, "Only Aqua is supported.");
    gBits8(); 	
    gBits8();
    gBits8();
    gBits8();
    
    gSizet	= gBits32;
    gInt	= gBits32;
    
    assert(gString(3) == "\4\2\0", "Unsupported bytecode target platform");
    end
    
    return ChunkDecode();
end






        local function _Returns(...)
            return Select('#', ...), {...};
        end;
        
        local function Wrap(Chunk, Env, Upvalues)
            local Instr = Chunk[1];
local Const = Chunk[3];
local Proto = Chunk[2];
        
            local function OnError(Err, Position) -- Handle your errors in whatever way.
                print(Err, Position);
            end;
        
            return function(...)
                local InstrPoint, Top	= 1, -1;
                local Vararg, Varargsz	= {}, Select('#', ...) - 1;
        
                local GStack	= {};
                local Lupvals	= {};
                local Stack		= setmetatable({}, {
                    __index		= GStack;
                    __newindex	= function(_, Key, Value)
                        if (Key > Top) then
                            Top	= Key;
                        end;
        
                        GStack[Key]	= Value;
                    end;
                });


            local function Loop()
                local Inst, Enum;
    
                while true do
                    Inst		= Instr[InstrPoint];
                    Enum		= Inst[6];
                    InstrPoint	= InstrPoint + 1;


if (Enum == 0) then -- SELF
local Stk	= Stack;
local A = Inst[1];
local B = Stk[Inst[2]];
local C = Inst[5] or Stk[Inst[3]];
Stk[A + 1] = B;
Stk[A] = B[C];

elseif (Enum == 2) then -- JMP
InstrPoint = InstrPoint + Inst[2];

elseif (Enum == 3) then -- GETGLOBAL
Stack[Inst[1]]	= Env[Const[Inst[2]]];

elseif (Enum == 4) then -- GETTABLE
local Stk	= Stack;
Stk[Inst[1]] = Stk[Inst[2]][Inst[5] or Stk[Inst[3]]];

elseif (Enum == 5) then -- GETUPVAL
Stack[Inst[1]]	= Upvalues[Inst[2]];

elseif (Enum == 6) then -- CLOSURE
local NewProto = Proto[Inst[2]];
local Stk = Stack;
local Indexes;
local NewUvals;
if (NewProto[4] ~= 0) then
Indexes = {};
NewUvals = setmetatable({}, {
__index = function(_, Key)
local Val = Indexes[Key];
return Val[1][Val[2]];
end,
__newindex = function(_, Key, Value)
local Val = Indexes[Key];
Val[1][Val[2]]	= Value;
end;
}
);
for Idx = 1, NewProto[4] do
local Mvm	= Instr[InstrPoint];
if (Mvm[6] == 11) then
Indexes[Idx - 1] = {Stk, Mvm[2]};
elseif (Mvm[6] == 5) then
Indexes[Idx - 1] = {Upvalues, Mvm[2]};
end;
InstrPoint = InstrPoint + 1;
end;
Lupvals[#Lupvals + 1] = Indexes;
end;
Stk[Inst[1]] = Wrap(NewProto, Env, NewUvals);

elseif (Enum == 7) then -- MUL
local Stk = Stack;
Stk[Inst[1]] = (Inst[4] or Stk[Inst[2]]) * (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 8) then -- LEN
Stack[Inst[1]] = #Stack[Inst[2]];

elseif (Enum == 10) then -- RETURN
local A = Inst[1];
local B	= Inst[2];
local Stk = Stack;
local Edx, Output;
local Limit;
if (B == 1) then
return;
elseif (B == 0) then
Limit = Top;
else
Limit = A + B - 2;
end;
Output = {};
Edx = 0;
for Idx = A, Limit do
Edx	= Edx + 1;
Output[Edx] = Stk[Idx];
end;
return Output, Edx;

elseif (Enum == 12) then -- SETGLOBAL
Env[Const[Inst[2]]] = Stack[Inst[1]];

elseif (Enum == 14) then -- CONCAT
local Stk	= Stack;
local B = Inst[2];
local K = Stk[B];
for Idx = B + 1, Inst[3] do
K = K .. Stk[Idx];
end;
Stack[Inst[1]] = K;


elseif (Enum == 16) then -- LOADK
Stack[Inst[1]]	= Const[Inst[2]];

elseif (Enum == 20) then -- TFORLOOP
local A = Inst[1];
local C	= Inst[3];
local Stk = Stack;
local Offset = A + 2;
local Result = {Stk[A](Stk[A + 1], Stk[A + 2])};
for Idx = 1, C do
Stack[Offset + Idx] = Result[Idx];
end;
if (Stk[A + 3] ~= nil) then
Stk[A + 2]	= Stk[A + 3];
else
InstrPoint	= InstrPoint + 1;
end;

elseif (Enum == 24) then -- POW
local Stk = Stack;
Stk[Inst[1]] = (Inst[4] or Stk[Inst[2]]) ^ (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 28) then -- EQ
local Stk = Stack;
local B = Inst[4] or Stk[Inst[2]];
local C = Inst[5] or Stk[Inst[3]];
if (B == C) ~= Inst[1] then
InstrPoint	= InstrPoint + 1;
end;

elseif (Enum == 32) then -- CLOSE
local A = Inst[1];
local Cls = {};
for Idx = 1, #Lupvals do
local List = Lupvals[Idx];
for Idz = 0, #List do
local Upv = List[Idz];
local Stk = Upv[1];
local Pos = Upv[2];
if (Stk == Stack) and (Pos >= A) then
Cls[Pos] = Stk[Pos];
Upv[1] = Cls;
end;
end;
end;

elseif (Enum == 33) then -- FORPREP
local A = Inst[1];
local Stk = Stack;
Stk[A] = assert(tonumber(Stk[A]), '`for` initial value must be a number');
Stk[A + 1] = assert(tonumber(Stk[A + 1]), '`for` limit must be a number');
Stk[A + 2] = assert(tonumber(Stk[A + 2]), '`for` step must be a number');
Stk[A]	= Stk[A] - Stk[A + 2];
InstrPoint	= InstrPoint + Inst[2];

elseif (Enum == 17) then -- TESTSET
local B = Stack[Inst[2]];
if Inst[3] then
 if B then
InstrPoint = InstrPoint + 1;
else
Stack[Inst[1]] = B;
end;
elseif B then
Stack[Inst[1]] = B;
else
InstrPoint = InstrPoint + 1;
end;

elseif (Enum == 21) then -- ADD
local Stk = Stack;
Stk[Inst[1]] = (Inst[4] or Stk[Inst[2]]) + (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 25) then -- NOT
Stack[Inst[1]] = (not Stack[Inst[2]]);

elseif (Enum == 29) then -- LE
local Stk = Stack;
local B = Inst[4] or Stk[Inst[2]];
local C = Inst[5] or Stk[Inst[3]];
if (B <= C) ~= Inst[1] then
InstrPoint	= InstrPoint + 1;
end;

elseif (Enum == 34) then -- FORLOOP
local A = Inst[1];
local Stk = Stack;
local Step = Stk[A + 2];
local Index	= Stk[A] + Step;
Stk[A]	= Index;
if (Step > 0) then
if Index <= Stk[A + 1] then
InstrPoint	= InstrPoint + Inst[2];
Stk[A + 3] = Index;
end;
else
if Index >= Stk[A + 1] then
InstrPoint	= InstrPoint + Inst[2];
Stk[A + 3] = Index;
end;
end;

elseif (Enum == 9) then -- SETUPVAL
Upvalues[Inst[2]]	= Stack[Inst[1]];

elseif (Enum == 11) then -- MOVE
Stack[Inst[1]]	= Stack[Inst[2]];

elseif (Enum == 13) then -- UNM
Stack[Inst[1]] = -Stack[Inst[2]];

elseif (Enum == 15) then -- DIV
local Stk = Stack;
Stk[Inst[1]] = (Inst[4] or Stk[Inst[2]]) / (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 18) then -- LOADNIL
local Stk	= Stack;
for Idx = Inst[1], Inst[2] do
Stk[Idx]	= nil;
end;

elseif (Enum == 22) then -- LT
local Stk = Stack;
local B = Inst[4] or Stk[Inst[2]];
local C = Inst[5] or Stk[Inst[3]];
if (B < C) ~= Inst[1] then
InstrPoint	= InstrPoint + 1;
end;

elseif (Enum == 26) then -- LOADBOOL
Stack[Inst[1]]	= (Inst[2] ~= 0);
if (Inst[3] ~= 0) then
InstrPoint	= InstrPoint + 1;
end;

elseif (Enum == 30) then -- TEST
if Inst[3] then
if Stack[Inst[1]] then
InstrPoint = InstrPoint + 1;
end
elseif Stack[Inst[1]] then
else
InstrPoint = InstrPoint + 1;
end;

elseif (Enum == 36) then -- CALL
local A	= Inst[1];
local B	= Inst[2];
local C	= Inst[3];
local Stk	= Stack;
local Args, Results;
local Limit, Edx;
Args	= {};
if (B ~= 1) then
if (B ~= 0) then
Limit = A + B - 1;
else
Limit = Top;
end;
Edx	= 0;
for Idx = A + 1, Limit do
Edx = Edx + 1;
Args[Edx] = Stk[Idx];
end;
Limit, Results = _Returns(Stk[A](unpack(Args, 1, Limit - A)));
else
Limit, Results = _Returns(Stk[A]());
end;
Top = A - 1;
if (C ~= 1) then
if (C ~= 0) then
Limit = A + C - 2;
else
Limit = Limit + A - 1;
end;
Edx	= 0;
for Idx = A, Limit do
Edx = Edx + 1;
Stk[Idx] = Results[Edx];
end;
end;

elseif (Enum == 37) then -- NEWTABLE
Stack[Inst[1]] = {};

elseif (Enum == 35) then -- VARARG
local A = Inst[1];
local B	= Inst[2];
local Stk, Vars	= Stack, Vararg;
Top = A - 1;
for Idx = A, A + (B > 0 and B - 1 or Varargsz) do
Stk[Idx]	= Vars[Idx - A];
end;

elseif (Enum == 31) then -- TAILCALL
local A = Inst[1];
local B	= Inst[2];
local Stk	= Stack;
local Args, Results;
local Limit;
local Rets = 0;
Args = {};
if (B ~= 1) then
if (B ~= 0) then
Limit = A + B - 1;
else
Limit = Top;
end;
for Idx = A + 1, Limit do
Args[#Args + 1] = Stk[Idx];
end;
Results = {Stk[A](unpack(Args, 1, Limit - A))};
else
Results = {Stk[A]()};
end;
for Index in pairs(Results) do
if (Index > Rets) then
Rets = Index;
end;
end;
return Results, Rets;

elseif (Enum == 1) then -- MOD
local Stk = Stack;
Stk[Inst[1]]	= (Inst[4] or Stk[Inst[2]]) % (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 19) then -- SUB
local Stk = Stack;
Stk[Inst[1]] = (Inst[4] or Stk[Inst[2]]) - (Inst[5] or Stk[Inst[3]]);

elseif (Enum == 23) then -- SETTABLE
local Stk = Stack
Stk[Inst[1]][Inst[4] or Stk[Inst[2]]] = Inst[5] or Stk[Inst[3]];

elseif (Enum == 27) then -- SETLIST
local A = Inst[1];
local B	= Inst[2];
local C	= Inst[3];
local Stk = Stack;
if (C == 0) then
InstrPoint = InstrPoint + 1;
C = Instr[InstrPoint].Value;
end;
local Offset = (C - 1) * 50;
local T	= Stk[A];
if (B == 0) then
B = Top - A;
end;
for Idx = 1, B do
T[Offset + Idx] = Stk[A + Idx];
end;

 end;
end;
end;


		local Args	= {...};
        local int = Chunk[28];

		for Idx = 0, Varargsz do
			if (Idx >= int) then
				Vararg[Idx - int] = Args[Idx + 1];
			else
				Stack[Idx] = Args[Idx + 1];
			end;
		end;

		local A, B, C	= pcall(Loop); -- Pcalling to allow yielding

		if A then -- We're always expecting this to come out true (because errorless code)
			if B and (C > 0) then -- So I flipped the conditions.
				return unpack(B, 1, C);
			end;

			return;
		else
			OnError(B, InstrPoint - 1); -- Didn't get time to test the `-1` honestly, but I assume it works properly
		end;
	end;
end;

local load_bytecode = function(BCode, Env) 
	local Buffer	= GetMeaning(BCode);

	return Wrap(Buffer, Env or getfenv(0)), Buffer;
end;
        
        load_bytecode("\27\65\113\117\97\105\0\1\4\4\4\2\0\12\0\0\0\64\83\99\114\105\112\116\46\116\120\116\0\1\0\0\0\0\0\0\0\0\0\2\0\159\0\0\0\0\0\0\12\0\0\2\18\1\0\4\144\2\0\4\12\1\2\6\18\0\0\8\12\2\4\2\18\1\4\0\144\0\2\2\144\4\0\4\64\5\0\8\64\6\0\12\64\4\8\0\72\7\0\20\12\8\0\24\64\2\10\2\144\7\0\20\12\1\12\4\84\6\12\18\86\2\10\2\144\7\0\20\12\1\12\18\78\6\12\4\76\2\10\2\144\7\0\20\12\9\13\4\28\6\12\2\28\2\10\2\144\7\0\20\12\10\13\4\60\2\10\2\144\7\0\20\12\1\12\4\4\6\12\18\6\2\10\2\144\7\0\20\12\1\12\18\98\2\12\12\96\9\13\12\96\2\10\2\144\7\0\20\12\11\0\24\64\2\10\2\144\7\0\20\12\1\2\4\112\0\0\2\8\0\12\2\104\1\12\0\104\2\10\2\144\7\0\20\12\9\3\24\90\0\0\2\8\0\12\2\104\1\12\0\104\2\10\2\144\7\0\20\12\12\3\26\118\0\0\2\8\0\12\2\104\1\12\0\104\2\10\2\144\7\0\20\12\14\0\24\64\2\10\2\144\15\0\20\64\16\0\24\64\17\0\28\64\4\0\32\64\5\0\26\132\5\20\0\44\18\0\44\12\11\22\38\18\9\24\0\44\2\22\4\144\10\10\22\56\248\255\25\136\7\0\24\12\5\14\0\44\2\12\2\144\7\0\24\12\20\0\28\64\2\12\2\144\0\12\0\148\21\0\24\48\21\0\24\12\4\13\44\94\21\0\24\12\0\0\28\24\23\13\14\92\21\0\24\12\6\12\46\2\9\0\32\64\0\18\0\104\4\12\2\144\24\0\24\64\0\14\0\104\6\16\0\52\7\14\0\100\8\12\0\44\7\0\32\12\25\0\36\64\2\16\2\144\1\0\32\24\2\0\36\24\3\0\0\44\4\0\0\44\8\0\0\44\0\20\0\148\4\0\44\64\2\0\48\12\12\24\52\18\4\0\52\64\9\0\56\64\3\24\4\144\4\0\52\64\7\0\46\132\27\0\60\12\15\30\56\18\10\32\0\44\18\0\68\12\17\34\38\18\16\37\28\84\2\34\0\144\0\30\2\144\246\255\45\136\9\22\0\44\10\24\0\32\29\0\52\12\10\28\0\44\2\26\0\144\0\22\2\144\7\0\44\12\30\0\48\64\2\22\2\144\31\0\44\12\10\24\0\44\2\22\8\144\3\0\2\8\7\0\64\12\14\34\0\44\15\36\0\44\3\32\2\144\0\22\4\80\249\255\1\8\7\0\44\12\32\0\48\64\2\22\2\144\13\22\0\72\11\26\0\68\0\0\2\8\12\26\0\44\12\22\0\72\0\22\0\120\0\0\2\8\12\22\0\44\7\0\44\12\33\0\48\64\2\22\2\144\1\0\0\40\3\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\3\0\0\6\0\0\0\0\0\12\12\1\8\0\44\2\10\0\44\0\12\0\44\4\6\2\144\1\0\0\40\0\0\0\0\1\0\0\0\4\6\0\0\0\112\114\105\110\116\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\1\0\0\3\0\0\0\0\2\0\86\2\2\0\40\1\0\0\40\0\0\0\0\1\0\0\0\3\0\0\0\0\0\0\8\64\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\3\1\0\0\18\0\0\0\0\4\0\148\0\6\0\140\0\4\2\108\0\0\12\64\0\6\0\36\1\0\12\12\0\8\0\44\2\0\20\12\2\12\0\44\2\10\4\144\0\12\0\20\1\14\0\20\5\6\2\144\2\6\0\20\0\8\0\44\2\6\0\124\0\6\0\40\1\0\0\40\0\0\0\0\3\0\0\0\4\3\0\0\0\58\41\0\4\6\0\0\0\112\114\105\110\116\0\4\7\0\0\0\117\110\112\97\99\107\0\0\0\0\0\0\0\0\0\0\0\0\0\34\0\0\0\4\3\0\0\0\111\115\0\4\5\0\0\0\116\105\109\101\0\4\5\0\0\0\109\97\116\104\0\4\11\0\0\0\114\97\110\100\111\109\115\101\101\100\0\3\0\0\0\0\0\0\240\63\3\0\0\0\0\0\0\0\64\4\12\0\0\0\72\101\108\108\111\32\119\111\114\108\100\0\4\6\0\0\0\112\114\105\110\116\0\4\17\0\0\0\45\45\45\45\60\32\77\97\116\104\32\62\45\45\45\45\0\3\0\0\0\0\0\0\20\64\3\0\0\0\0\0\0\228\63\4\26\0\0\0\45\45\45\45\45\45\45\45\45\101\113\44\108\116\44\108\101\45\45\45\45\45\45\45\45\0\3\0\0\0\0\0\0\8\64\3\0\0\0\0\0\0\32\64\4\10\0\0\0\45\45\45\45\45\45\45\45\45\0\4\1\0\0\0\0\3\0\0\0\0\0\64\88\64\3\0\0\0\0\0\192\94\64\4\7\0\0\0\115\116\114\105\110\103\0\4\5\0\0\0\99\104\97\114\0\4\36\0\0\0\45\45\45\45\45\45\45\45\45\115\101\108\102\32\38\32\115\101\116\103\108\111\98\97\108\45\45\45\45\45\45\45\45\45\45\0\4\2\0\0\0\112\0\4\4\0\0\0\102\111\111\0\4\4\0\0\0\97\98\99\0\3\0\0\0\0\0\0\36\64\4\53\0\0\0\45\45\45\45\118\97\114\97\114\103\115\44\32\99\97\108\108\44\32\116\97\105\108\99\97\108\108\32\45\45\45\45\32\32\38\32\111\116\104\101\114\32\115\116\117\102\102\45\45\45\45\45\0\4\7\0\0\0\114\97\110\100\111\109\0\4\6\0\0\0\116\97\98\108\101\0\4\7\0\0\0\105\110\115\101\114\116\0\4\7\0\0\0\117\110\112\97\99\107\0\4\24\0\0\0\45\45\45\45\45\45\45\45\45\116\102\111\114\108\111\111\112\45\45\45\45\45\45\0\4\6\0\0\0\112\97\105\114\115\0\4\34\0\0\0\45\45\45\45\45\45\60\32\116\101\115\116\32\38\32\116\101\115\116\115\101\116\32\62\45\45\45\45\45\45\45\45\45\0\4\9\0\0\0\67\111\109\112\108\101\116\101\0\0\0\0\0\0\0\0\0\0\0\0\0")()
    