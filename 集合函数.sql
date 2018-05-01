settype.COUNT   --集合长度
settype.LIMIT   --集合总长度（含没有定义的）
settype.FIRST   --集合首个索引
settype.LAST    --集合最后的索引
settype.NEXT(next_index)    --集合下一个
settype.DELETE(x) | settype.DELETE(a, b)    --集合删除（索引）
settype.TRIM([x])    --删除最后一[x]个数据
settype.EXISTS(x)   --集合是否存在元素
settype.EXTEND(a [, b])   --集合扩展长度（a）, 使用第b个内容填充