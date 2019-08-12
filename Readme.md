# 目前数量不多 暂时不进行整理，以后以文件夹为说明
+ 这是一个学习shell语言的Request
+ 精选一些.sh文件方便学习
+ 同时深化学习git用法。


PS:由windows平台迁移到unix系统下容易引发的问题：Linux执行脚本却提示No such file or directorydos格式文件传输到unix系统时,会在每行的结尾多一个^M,当然也有可能看不到,但是在vi的时候,会在下面显示此文件的格式,比如 "dos.txt" [dos] 120L, 2532C 字样,表示是一个[dos]格式文件,如果是MAC系统的,会显示[MAC],因为文件格式的原因有时会导致我们的unix程序,或者shell程序出现错误,那么需要把这些dos文件格式转换成unix格式,方法是


查看文件格式  用vim 打开出错的文件    按 ESC键     再按shift+冒号   输入 set  ff  回车   可以看见 该文件的格式 fileformat=dos
按shift + 冒号  输入  set ff=unix 回车 发现没反应，那就对了。 
可以按 shift + 冒号  set ff 查看  fileformat=unix 

```bash
    vi  dos.txt        
    :set fileformat=unix
    :wq
    
    # 或者
    vim halo.sh
    :set ff=unix
    :wq
    
    #查看文件fileformat
    vim halo.sh
    :set ff
```    
