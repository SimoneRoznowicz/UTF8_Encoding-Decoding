codepoints = 4000;
error = 0;
nbyte = 1;
nbyteFinalCodepoint = 4;
codepointlength=strcat('uint',num2str(nbyte*8));
finalcodepointlength=strcat('uint',num2str(nbyteFinalCodepoint*8));

namefileread = 'UTF8.data';
fidr = fopen(namefileread,'r');
namefilewrite = 'output.data';
fidw = fopen(namefilewrite,'w');

for q = 1:codepoints
    codepoint = fread(fidr,1,codepointlength);
    char_array = flip(bitget(codepoint,1:8));
    %parto a leggere il primo byte del prossimo codepoint
    if(char_array(1) == 0)                          %codepoint lungo 1byte
        finalcodepoint = uint32(codepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 0)  
        disp("unification");
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)))  %leggo un altro byte e creo un unicoo array con il primo 
        if checkerr(char_array,[9,10])>0        %controllo con la funzione checkerr se trovo le sequenze di 1 0 nelle giuste posizioni. Eventualmente segnalo l'errore 
           error = error+1;
        end
        char_array = bitsRemove(char_array, [1,1,1,6,6])
        finalcodepoint = calc_val(char_array); 
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 1 && char_array(4) == 0)
        disp("unification")
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));  %leggo altri 2 byte e creo un unicoo array con il primo
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)))
        if checkerr(char_array,[9,10,17,18])>0      
           error = error+1;
        end
        char_array = bitsRemove(char_array, [1,1,1,1,5,5,11,11])
        finalcodepoint = calc_val(char_array);
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 1 && char_array(4) == 1 && char_array(5) == 0)
        disp("unification")
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));  %leggo altri 3 byte e creo un unicoo array con il primo
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)))
        if checkerr(char_array,[9,10,17,18,25,26])>0      
           error = error+1
        end
        char_array = bitsRemove(char_array, [1,1,1,1,1,4,4,10,10,16,16])
        finalcodepoint = calc_val(char_array);
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 1 && char_array(4) == 1 && char_array(5) == 1 && char_array(6) == 0)
        disp("unification")
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));  %leggo altri 4 byte e creo un unicoo array con il primo
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)))
        if checkerr(char_array,[9,10,17,18,25,26,33,34])>0      
           error = error+1;
        end     
        char_array = bitsRemove(char_array, [1,1,1,1,1,1,3,3,9,9,15,15,21,21])
        finalcodepoint = calc_val(char_array);
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 1 && char_array(4) == 1 && char_array(5) == 1 && char_array(6) == 1 && char_array(7) == 0)
        disp("unification")
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));  %leggo altri 5 byte e creo un unicoo array con il primo
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8))) 
        if checkerr(char_array,[9,10,17,18,25,26,33,34,41,42])>0      
           error = error+1;
        end
        char_array = bitsRemove(char_array, [1,1,1,1,1,1,1,2,2,8,8,14,14,20,20,26,26])
        finalcodepoint = calc_val(char_array);
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    elseif  (char_array(1) == 1 && char_array(2) == 1 && char_array(3) == 1 && char_array(4) == 1 && char_array(5) == 1 && char_array(6) == 1 && char_array(7) == 1 && char_array(8) == 0)
        disp("unification")
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));  %leggo altri 6 byte e creo un unicoo array con il primo
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)));
        char_array = unify(char_array,flip(bitget(fread(fidr,1,codepointlength),1:8)))
        if checkerr(char_array,[9,10,17,18,25,26,33,34,41,42,49,50])>0      
           error = error+1;
        end
        char_array = bitsRemove(char_array, [1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,3,9,9,15,15,21,21,27,27])
        finalcodepoint = calc_val(char_array);
        disp("VALORE")
        finalcodepoint = uint32(finalcodepoint)
        fwrite(fidw,finalcodepoint,finalcodepointlength);
    else
        error = error+1;
        disp("error")
    end
end
disp("number errors:")
disp(error)
fclose(fidr);
fclose(fidw);

function unified_array = unify(array1,array2)
    unified_array = zeros(1,length(array1)+length(array2));
    for k=1:length(array1)
        unified_array(k) = array1(k);
    end
    k=k+1;
    for m=1:length(array2)
        unified_array(k) = array2(m);
        k=k+1;
    end
end

%prestare attenzione all'array_position da scegliere opportunamente nel
%chiamante. La funzione, dato un array di bit e un array di posizione,
%rimuove i bit di maschera in corrispondenza delle posizioni indicate
function modified_array2 = bitsRemove(passed_array, array_position)
    for i=1:length(array_position)
        modified_array2 = bitRemove(passed_array, array_position(i));
        passed_array = modified_array2;
    end
end

function modified_array = bitRemove(passed_array, position)
    modified_array = zeros(1,length(passed_array)-1);
    i = 1;
    while (i <= length(passed_array))
        if (i == position)
            for j = i:length(passed_array)-1
                passed_array(j) = passed_array(j+1);
            end
        end
        i=i+1;
    end
    for i=1:length(passed_array)-1
        modified_array(i) = passed_array(i);
    end
end

%calcola il valore del codepoint a partire dall'array di bit (privato della maschera)
function val = calc_val(array)
    max=length(array);
    val=0;
    for t=1:max
        val=val + array(t)*2^(max-t);
        val=uint64(val);
    end
end

%dato un array di bit e un array di posizioni in cui bisogna controllare la
%presnza della sequenza di maschera 1 0, la funzione ritorna 0 (se va tutto bene)
%o 1 (se non viene identificata la sequenza)
%La funzione prevede che vengano passate solo le posizioni delle sequenze 1 0
function err = checkerr(array,array10)
    i=1;
    err=0;
    while i<=length(array10) 
        if array(array10(i))~=1 && array(array(i+1))~=0
            err=1;
            break;
        end
        i=i+2;
    end
end
