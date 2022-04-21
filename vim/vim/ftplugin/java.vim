setlocal omnifunc=javacomplete#Complete
setlocal sw=4 ts=4 expandtab autoindent
setlocal textwidth=100
setlocal colorcolumn=+1

highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

call IMAP('class`', "public class <+name+> {\<CR><++>\<CR>}", 'java')
call IMAP('main`', "public static void main(String[] args) {\<CR><+in+>\<CR>}", 'java')
call IMAP('outf`', "System.out.printf(<+out+>);<++>", 'java')
call IMAP('outl`', "System.out.println(<+out+>);<++>", 'java')
call IMAP('aufg`', "public static void aufgabe<+number+>() {\<cr>System.out.println(\"\\nAufgabe <++>\");\<cr>}", 'java')

call IMAP('test`', "import org.junit.Before;\<CR>import org.junit.Test;\<CR>import static org.junit.Assert.*;\<CR>\<CR>public class <+name+> {\<CR><++>\<CR>}", 'java')
