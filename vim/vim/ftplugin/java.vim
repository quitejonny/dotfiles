setlocal omnifunc=javacomplete#Complete
setlocal sw=2 ts=2 expandtab autoindent
setlocal textwidth=100
setlocal colorcolumn=+1

highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

call WIMAP('class`', "public class <+name+> {\<CR><++>\<CR>}", 'java')
call WIMAP('main`', "public static void main(String[] args) {\<CR><+in+>\<CR>}", 'java')
call WIMAP('outf`', "System.out.printf(<+out+>);<++>", 'java')
call WIMAP('outl`', "System.out.println(<+out+>);<++>", 'java')
call WIMAP('aufg`', "public static void aufgabe<+number+>() {\<cr>System.out.println(\"\\nAufgabe <++>\");\<cr>}", 'java')

call WIMAP('test`', "import org.junit.Before;\<CR>import org.junit.Test;\<CR>import static org.junit.Assert.*;\<CR>\<CR>public class <+name+> {\<CR><++>\<CR>}", 'java')
