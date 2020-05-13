import re
from random import choices
with open('./op1', 'r') as f:
    data = f.read()

# output = []

exps = ['^([a-zA-Z0-9]*) = ([a-zA-Z0-9]*)$', '(^L[0-9]):$', '^iffalse ([a-z0-9]*) (==| >|<|!=) ([a-z0-9]*) goto (L[0-9]*)',
        '^([a-zA-Z0-9]*) = ([a-zA-Z0-9]*)? ([+|\-|*|\/]) ([a-zA-Z0-9]*)', '^goto (L[0-9]*)$']
out = []

varDict = {}
regs = set(['R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6'])


def add_to_reg(token):
    # print(token)
    if token in varDict.keys():
        print(token + 'is old but still being  added ????')
    else:
        # all regs used
        if regs - set(map(lambda x: x[0], varDict.items())) == []:
            _, minv = min(varDict.items(), key=lambda k, v: v[1])
            varDict[token] = (minv[0][0], 1)
        # not all regs used
        else:
            varDict[token] = (
                choices(list(regs - usedRegs()), k=1), 1)
    # print(token,varDict[token])
    
    
    return varDict[token][0]

def usedRegs():
    usedregs = []
    for i in varDict.values():
        usedregs.append(i[0])
    if len(usedregs) >0 :
        return set(usedregs[0])
    return set([])

def get_reg(token):
    print(varDict[token])

    if token not in varDict.keys():
        print(token + ' not found in regs , yet being used ??')
    else:
        varDict[token] = (varDict[token][0], varDict[token][1]+1)
        return varDict[token][0]


def form(i, tokens):
    if i == 0:

        if tokens[0][0] != 'R':
            # a = 3
            reg = add_to_reg(tokens[0])
        
            out.append('ST '+reg[0]+', $'+tokens[1])
        else:
            out.append('LD '+tokens[0]+', $'+tokens[1])
    elif i == 1:
        # l1 :
        out.append(tokens[0]+':')
    elif i == 2:
        # iffalse
        reg = get_reg(tokens[0])
        # print(reg)
        out.append('SUB '+reg[0]+' '+reg[0] + ' '+tokens[2])
        if tokens[1] == '<':
            out.append('BLZ '+reg[0]+' '+tokens[3])
        elif tokens[1] == '>':
            out.append('BGZ '+reg[0]+' '+tokens[3])
        else:
            out.append('BEZ '+reg[0]+' '+tokens[3])
    elif i == 4:
        # goto
        out.append('BR '+tokens[0])
    elif i == 3:
        reg = get_reg(tokens[1])
        if tokens[2] == '+':
            out.append('ADD ' + reg[0]+' '+reg[0]+' '+tokens[3])
        elif tokens[2] == '-':
            out.append('SUB ' + reg[0]+' '+reg[0]+' '+tokens[3])
        elif tokens[2] == '*':
            out.append('MUL ' + reg[0]+' '+reg[0]+' '+tokens[3])
        else:
            out.append('DIV ' + reg[0]+' '+reg[0]+' '+tokens[3])

        if tokens[0][0] == 'R':
            out.append('MOV '+tokens[0]+' '+reg[0])
        else:
            out.append('ST $'+tokens[0] + ' '+reg[0])


def matchRe(data):
    for line in data.split('\n'):
        for i in range(len(exps)):
            try:
                res = re.search(exps[i], line)
                if res:
                    # print(res.groups(), i)
                    form(i, res.groups())
                    break
            except AttributeError as _:
                continue


matchRe(data)
with open('finalOut', 'w') as f:
    print(*out, sep='\n', file=f)
