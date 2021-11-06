 nbyte = 4;                     %in seguito nbyte cambiera' all'inizio di ogni if
 codepointlength=strcat('uint',num2str(nbyte*8));
 totchars = 4000;
 char=zeros(totchars,1, 'uint32');
 namefile ='input.data';
 fid = fopen(namefile,'r+');
 for nchar = 1:length(char)
     codepoint = fread(fid,1,codepointlength);
     codepoint =  uint32(codepoint);
     char(nchar) = codepoint;       %SALVO NELL'ARRAY DI NOME char tutti I CODEPOINT
 end
 fclose(fid);
 
 %*************************************************************************
 
 namefile ='UTF8.data';
 fid = fopen(namefile,'w+');
 nbyte = 1;     
 codepointlength=strcat('uint',num2str(nbyte*8));
 
 for i = 1:totchars
     %distinzione della codifica da eseguire in base al numero da tradurre
     if (char(i) <= 2^7-1)        %127        usa 8 bit totali
         nbyte = 1;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:7));            %rovescio l'array che rappresenta in binario char(i)
         char_array = bitsChange(char_array, 1, [0]);       %aggiungo uno zero (maschera) all'array di bit
         codepoint = calc_val(char_array);                  %calcolo il valore del codepoint dall'array di bit
         codepoint = uint32(codepoint);                     %rendo codepoint un unsigned byte a 32 bit
         fwrite(fid,codepoint,codepointlength);             %codepoinlength e' lungo 1 byte
    
     elseif (char(i) <= 2^11-1)   %2047      usa 16 bit totali
         nbyte = 2;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:11))            %inverto l'ordine dei byte per avere i piu' significativi a sinistra
         char_array = bitsChange(char_array, 1, [1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]) 
         codepoint = calc_val(char_array);
         codepoint = uint32(codepoint);
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 2 byte
         
     elseif (char(i) <= 2^16-1)   %65535     usa 24 bit totali
         nbyte = 3;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:16))
         char_array = bitsChange(char_array, 1, [1,1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]);
         char_array = bitsChange(char_array, 17, [1,0])
         codepoint = calc_val(char_array);
         codepoint = uint32(codepoint);
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 3 byte
         
     elseif (char(i) <= 2^21-1)   %2097151   usa 32 bit totali
         nbyte = 4;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:21))
         char_array = bitsChange(char_array, 1, [1,1,1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]);
         char_array = bitsChange(char_array, 17, [1,0]);
         char_array = bitsChange(char_array, 25, [1,0])
         codepoint = calc_val(char_array);
         codepoint = uint32(codepoint);
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 4 byte
         
     elseif (char(i) <= 2^26-1)  %67108863
         nbyte = 5;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:26))
         char_array = bitsChange(char_array, 1, [1,1,1,1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]);
         char_array = bitsChange(char_array, 17, [1,0]);
         char_array = bitsChange(char_array, 25, [1,0]);
         char_array = bitsChange(char_array, 33, [1,0])
         codepoint = calc_val(char_array);
         codepoint = uint64(codepoint);                 %la rappresentazione a 32 bit non e' sufficiente da ora in poi
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 5 byte
     
     elseif (char(i) <= 2^31 -1)  %2147483648
         nbyte = 6;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:31))
         char_array = bitsChange(char_array, 1, [1,1,1,1,1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]);
         char_array = bitsChange(char_array, 17, [1,0]);
         char_array = bitsChange(char_array, 25, [1,0]);
         char_array = bitsChange(char_array, 33, [1,0]);
         char_array = bitsChange(char_array, 41, [1,0])
         codepoint = calc_val(char_array);
         codepoint = uint64(codepoint);
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 6 byte
     
     else %(char(i)>2^31-1)     >2147483648
         nbyte = 7;
         codepointlength=strcat('ubit',num2str(nbyte*8));
         char(i)
         char_array = flip(bitget(char(i),1:32))
         char_array = bitsChange(char_array, 1, [1,1,1,1,1,1,1,0]);
         char_array = bitsChange(char_array, 9, [1,0]);
         %aggiungo 4 bit per avere alla fine byte completi (per arrivare a 56 bit, occupando quindi 7 byte
         char_array = bitsChange(char_array, 11, [0,0,0,0]);
         char_array = bitsChange(char_array, 17, [1,0]);
         char_array = bitsChange(char_array, 25, [1,0]);
         char_array = bitsChange(char_array, 33, [1,0]);
         char_array = bitsChange(char_array, 41, [1,0]);
         char_array = bitsChange(char_array, 49, [1,0])  
         codepoint = calc_val(char_array); 
         codepoint = uint64(codepoint);
         fwrite(fid,codepoint,codepointlength);         %codepoinlength e' lungo 7 byte
     end
 end   
fclose(fid);

%la funzione, dato l'array di bit rappresentante il codepoint estratto,
%la posizione in cui voglio inserire i bit per la maschera, e l'array di
%bit di maschera, ritorna l'array di bit risultante
function modified_array = bitsChange(passed_array, position, array_to_add)
    modified_array = zeros(1,length(passed_array) + length(array_to_add));
    k = 1;
    i = 1;
    while (i <= length(modified_array))
        if (length(array_to_add) == 0)
            modified_array = passed_array;
            return;
        end
        if (i == position)
            for j = 1:length(array_to_add)
                modified_array(i) = array_to_add(j);
                i = i+1;
            end
        else
            modified_array(i) = passed_array(k);
            k = k+1;
            i = i+1;
        end
    end
end

%calcolo del valore del codepoint (tenendo cconto della maschera e della codifica little
%endian con cui i byte di ogni codepoint vengono scritti nel file utf8.data
function val = calc_val(array)
    max=length(array);        %numero di bytes
    val=0;
    t=8;
    a=1;
    while t<=max
        val=val + array(t)*2^(a-1);
        val=uint64(val);            
        t=t-1;
        a=a+1;
        if(mod(t,8)==0)
            t=t+16;
        end
    end
end
