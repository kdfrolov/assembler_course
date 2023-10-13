format PE64 Console 5.0 ;������ �������
entry Start ;����� ����� � ���������������� ���������
include 'win64a.inc' ;����������� ��������� � ����������
section '.bss' readable writeable ;���.������ = ����� ��� �����/������ ����� �������
 readBuf db ?
section '.idata' import data readable ;���.������ ������������� ������
 library kernel,'KERNEL32.DLL'
 import kernel, SetConsoleTitleA, 'SetConsoleTitleA', GetStdHandle, 'GetStdHandle',\ ;������ ����������� ������� ������
 WriteConsoleA, 'WriteConsoleA', ReadConsoleA, 'ReadConsoleA', ExitProcess, 'ExitProcess'
section '.data' data readable writeable ;������ ������
 mem1 dd 221 ;������ ���������� � ������ �������� Word=16 ��� ��� 2 �����
 mem2 dd 20 ;������ ���������� � ������ �������� 2 �����
 mem3 dd 0 ;�������
 conTitle db 'Results', 0 ;����-��������������� ������ ������������ �������� = �������� ����������� ����
 mes1 db 'mem1 is divisable to mem2', 0dh, 0ah, 0 ;����-��������������� ������ ������������ �������� = ??
 mes1Len = $-mes1 ;����� ������=���������, ����������� ��� ������� ����� ������� ���������� ($) � ������� ������ ������ mes
 mes2 db 'mem1 is not divisable to mem2', 0dh, 0ah, 0
 mes2Len = $-mes2
 hStdIn dd 0 ;����� ���������� = ���������� ��� ����������� �����/������
 hStdOut dd 0
 chrsRead dd 0
 chrsWritten dd 0
 STD_INP_HNDL dd -10
 STD_OUTP_HNDL dd -11
section '.text' code readable executable ;������ ���� (���������� � ���������)
Start: ;�����=����� ����� � ���������
 push rax ;���������� � ����� �������� r�� ��� ������������ ������������� ��� ������ API-�������
 xor edx,edx ;��������� �������� edx ����� ��������� ����������� ���
 mov eax,[mem1] ;����������� ������ ���������� mem1 ��� �������� �� ���������
 div [mem2] ;������� �������� 8-��������� ����� �� ���� ��������� edx:eax �� ������ ����� � ���������� mem2
 mov [mem3],edx ;����������� ������� �� ������� �� edx � ���������� mem3
 pop rax ;�������������� �� ����� �������� r�� ��� ����������� ������ API-�������, ������������ ��� ��������
 invoke SetConsoleTitleA, conTitle ;����� API-������� ������������ ��������� �������
 test eax, eax ;������������ ��������� �� ����������� �������� ��� (������������� ??
 jz Exit ;�������� ����� �������� ���������� (� ���), ���� ����, �� ������� �� ����� Exit
 invoke GetStdHandle, [STD_OUTP_HNDL] ;����� API-������� ??
 mov [hStdOut], eax ;����������� ����������� ��� (������������� ��������) � ���������� � �� ��� ??
 invoke GetStdHandle, [STD_INP_HNDL] ;����� API-������� ??
 mov [hStdIn], eax ;����������� ����������� ��� (������������� ��������) � ���������� � �� ��� ??
 cmp [mem3],0 ;�������� ������� �� ������� � ����
 jz ZERO ;���� ���� �������� ���������� ���������� (������� �� ������� =0), �� ������� �� ����� ZERO
 invoke WriteConsoleA, [hStdOut], mes2, mes2Len, chrsWritten, 0 ;����� � ������� ��������� � �� ���������
 jmp Exit
ZERO:
 invoke WriteConsoleA, [hStdOut], mes1, mes1Len, chrsWritten, 0 ;����� � ������� ��������� � ��������� mem1 ����� mem2

Exit:
 invoke ReadConsoleA, [hStdIn], readBuf, 1, chrsRead, 0 ;����� API-������� ?? �������� �����
 invoke ExitProcess, 0 ;����� API-������� ������������ ���������� ���������
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
