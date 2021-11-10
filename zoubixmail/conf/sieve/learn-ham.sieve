equire ["vnd.dovecot.pipe", "copy", "imapsieve", "environment", "variables"];

if environment :matches "imap.mailbox" "*" {
    set "mailbox" "${1}";
}

if string "${mailbox}" "Trash" {
    stop;
}

pipe :copy "rspamc" ["learn_ham"];