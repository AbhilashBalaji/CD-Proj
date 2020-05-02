import re
with open('./op1', 'r') as f:
    data = f.read()

# output = []

exps=['^([a-zA-Z0-9]*) = ([a-zA-Z0-9]*)$', '(^L[0-9]):$', '^iffalse ([a-z0-9]*) (==| >|<|!=) ([a-z0-9]*) goto (L[0-9]*)', '^([a-zA-Z0-9]*) = ([a-zA-Z0-9]*)? ([+|\-|*|\/]) ([a-zA-Z0-9]*)', '^goto (L[0-9]*)$']
out =[]

def form(i,tokens):
    if i == 0:
        if  tokens[0][0] !='t':
            out.append('ST '+tokens[0]+', $'+tokens[1])
        else :
            out.append('LD '+tokens[0]+', $'+tokens[1])
    elif i == 1 :
        out.append(tokens[0]+':')
    elif i == 2:
        out.append('SUB '+tokens[0]+' '+tokens[0]+ ' '+tokens[2])
        if tokens[1] == '<':
            out.append('BLZ '+tokens[0]+' '+tokens[3])
        elif tokens[1] == '>': 
            out.append('BGZ '+tokens[0]+' '+tokens[3])
        else :
            out.append('BEZ '+tokens[0]+' '+tokens[3])
    elif i == 4:
        out.append('BR '+tokens[0])
    elif i == 3 :
        # if tokens[0][0] == 't':
        #     out.append()
        if tokens[2] == '+':
            # if tokens[0][0] == 't':
            out.append('ADD ' + tokens[1]+' '+tokens[1]+' '+tokens[3])
        elif tokens[2] == '-':
            out.append('SUB ' + tokens[1]+' '+tokens[1]+' '+tokens[3])
        elif tokens[2] == '*':
            out.append('MUL ' + tokens[1]+' '+tokens[1]+' '+tokens[3])
        else : 
            out.append('DIV ' + tokens[1]+' '+tokens[1]+' '+tokens[3])

        if tokens[0][0] == 't':
            out.append('MOV '+tokens[0]+' '+tokens[1])
        else :
            out.append('ST $'+tokens[0] +' '+tokens[1])
                        

def matchRe(data):
    for line in data.split('\n'):
        for i in range(len(exps)):
            try:
                res = re.search(exps[i] , line)
                if res :
                    print(res.groups(),i)
                    form(i,res.groups())
                    break
            except AttributeError as e:
                continue


matchRe(data)
with open('finalOut','w') as f:
    print(*out,sep='\n',file =f)  


