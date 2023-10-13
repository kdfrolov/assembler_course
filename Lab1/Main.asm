format PE64 Console 5.0 ;формат проекта
entry Start ;точка входа в пользовательскую программу
include 'win64a.inc' ;подключение библиотек и заголовков
section '.bss' readable writeable ;доп.секция = буфер для ввода/вывода через консоль
 readBuf db ?
section '.idata' import data readable ;доп.секция импортируемых данных
 library kernel,'KERNEL32.DLL'
 import kernel, SetConsoleTitleA, 'SetConsoleTitleA', GetStdHandle, 'GetStdHandle',\ ;символ продолжения длинной строки
 WriteConsoleA, 'WriteConsoleA', ReadConsoleA, 'ReadConsoleA', ExitProcess, 'ExitProcess'
section '.data' data readable writeable ;секция данных
 mem1 dd 221 ;первая переменная в памяти размером Word=16 бит или 2 Байта
 mem2 dd 20 ;вторая переменная в памяти размером 2 Байта
 mem3 dd 0 ;остаток
 conTitle db 'Results', 0 ;нуль-терминированная строка однобайтовых символов = название консольного окна
 mes1 db 'mem1 is divisable to mem2', 0dh, 0ah, 0 ;нуль-терминированная строка однобайтовых символов = ??
 mes1Len = $-mes1 ;длина строки=константа, вычисляемая как разница между текущим положением ($) и адресом начала строки mes
 mes2 db 'mem1 is not divisable to mem2', 0dh, 0ah, 0
 mes2Len = $-mes2
 hStdIn dd 0 ;набор переменных = параметров для консольного ввода/вывода
 hStdOut dd 0
 chrsRead dd 0
 chrsWritten dd 0
 STD_INP_HNDL dd -10
 STD_OUTP_HNDL dd -11
section '.text' code readable executable ;секция кода (инструкции и директивы)
Start: ;метка=точка входа в программу
 push rax ;сохранение в стеке регистра rах для последующего использования при вызове API-функции
 xor edx,edx ;обнуление регистра edx через побитовое исключающее или
 mov eax,[mem1] ;копирование первой переменной mem1 для проверки на кратность
 div [mem2] ;деление большого 8-байтового числа из пары регистров edx:eax на второе число – переменную mem2
 mov [mem3],edx ;перемещение остатка от деления из edx в переменную mem3
 pop rax ;восстановление из стека регистра rах для корректного вызова API-функции, использующей это значение
 invoke SetConsoleTitleA, conTitle ;вызов API-функции установления заголовка консоли
 test eax, eax ;установление признаков по содержимому регистра еах (возвращаемого ??
 jz Exit ;проверка флага нулевого результата (в еах), если ноль, то переход на метку Exit
 invoke GetStdHandle, [STD_OUTP_HNDL] ;вызов API-функции ??
 mov [hStdOut], eax ;копирование содержимого еах (возвращаемого значения) в переменную в ОП для ??
 invoke GetStdHandle, [STD_INP_HNDL] ;вызов API-функции ??
 mov [hStdIn], eax ;копирование содержимого еах (возвращаемого значения) в переменную в ОП для ??
 cmp [mem3],0 ;сравнить остаток от деления с нулём
 jz ZERO ;если флаг нулевого результата установлен (остаток от деления =0), то перейти на метку ZERO
 invoke WriteConsoleA, [hStdOut], mes2, mes2Len, chrsWritten, 0 ;вывод в консоль сообщения о не кратности
 jmp Exit
ZERO:
 invoke WriteConsoleA, [hStdOut], mes1, mes1Len, chrsWritten, 0 ;вывод в консоль сообщения о кратности mem1 числу mem2

Exit:
 invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0 ;вызов API-функции ?? ожидания ввода
 invoke ExitProcess, 0 ;вызов API-функции стандартного завершения программы
  chrsRead    dd 0
  chrsWritten dd 0

  STD_INP_HNDL  dd -10
  STD_OUTP_HNDL dd -11

section '.bss' readable writeable

  readBuf  db ?

section '.idata' import data readable

  library kernel,'KERNEL32.DLL'

  import kernel,\
    SetConsoleTitleA, 'SetConsoleTitleA',\
    GetStdHandle, 'GetStdHandle',\
    WriteConsoleA, 'WriteConsoleA',\
    ReadConsoleA, 'ReadConsoleA',\
    ExitProcess, 'ExitProcess'
