
--16进制解析 unit_tested2204071739
function ParsingMultiAscii(tstr)
local ex={}
local tbval={} 
ex[1]={}
ex[9]={}
for k,v in pairs(ex[8]) do
if pcall(function()
ex[8][k]=encoder.fromHex(v)
end)
then 
else
print("wrong ex[8] set ,reloading value...")
file.remove("val_initialed.lua")
timer_counter(10,crvalue) 
end  

end
--所有传感器数据总数
local allvalue=0
for k,v in pairs(ex[4]) do allvalue=allvalue+v end
ex[9][1]="HexString2Int"
ex[9][2]="HexString2Int32"
ex[9][3]="Hex2Float"
ex[9][4]="asciistr2num"
local startuniquenum=#ex[8]
--过滤数据提升性能----------------------
	local z
	for a=1,startuniquenum do
		z=string.find(tstr,ex[8][a])or z
	end
	if z==nil then return end
	if not(ex[2] and  ex[3] and ex[4] and ex[5] and ex[6] and ex[7] and ex[8]  and ex[10]) then 
	print("parsing params absent please set it")
	return
	end
-----------------------------------------
    for a=1,startuniquenum do
	ex[1][a]=string.find(tstr,ex[8][a])
        if ex[1][a] then
                if string.len(tstr)>=ex[6][a] then--判断数据长度
                    tstr=string.upper(tstr)
                    tstr=string.sub(tstr,ex[1][a],ex[6][a]+ex[1][a]-1)
					--当前执行到第几条
                    local s
                          --if CheckCRC16(tstr)==nil then return end
                                --当前类型数据前面数据条数累计
                                local b=0
                                if a==1 then b=0
                                else
									--如果数组索引发生运算需要加上括号
                                    for k=2,a do b=b+(ex[4][k-1]) end
                                end
                       -------------------------------------------------------
                       ----------根据当前协议前面累计条数，计算他属于第几条
                                for n=1,ex[4][a] do 
                                    s=b+n
                       -------------------------------------------------------
                                    tbval[s]=""
									--把截取出来的16进制数据组合成单个字符串
                                    for v=1,ex[5][a] do
                                        local t=ex[3][a]-1+((n-1)*ex[5][a])+v
                                        tbval[s]=tbval[s]..string.format("%02X",tstr:sub(t,t):byte())
                                    end
                                    --************缓存数据转换函数
									if _G[ex[9][ex[7][a]]]==nil then print("wrong exefunc") return end
                                    tbval[s]=_G[ex[9][ex[7][a]]](tbval[s])
									--单位转换*************
									if (ex[2][s] and tbval[s])  then tbval[s]=(tbval[s]*ex[2][s]) end
									--按顺序取出需要的值
									for k,v in pairs(ex[10]) do
										if tbval[v] then
											B_Val[k]=tbval[v]
										end
									end
									------------------------
                                end
                end
        end
   end
return tb_val
end
