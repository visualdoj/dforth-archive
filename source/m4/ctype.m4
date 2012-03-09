define(`CON', `$1$2')
divert(`1')ifdef(`__windows__',`type',`cat') divert(`3')> temp/all.cmd divert(`-1')define(`GROUP',`divert(`2')CON(commands,ifdef(`__windows__',`\',`/')$1.cmd) divert(`-1')')
