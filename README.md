# cb2pdf

cb2pdf is a comic book to pdf converter based on ruby. It provides a small API
as well as a command line tool.

It uses 7zip to decompress a comic book archive and the two gems prawn and fastimage
to assemble the pdf. On windows decompressing should work out of the box. On other OSs
7zip must be installed.

Supported comic book formats are `cbr`, `cbz` and `cb7` containing images of format
`png`, `jpg` or `jpeg`.
 
## How to use
API:

    # set 7zip path if conversion doesn't work out of the box
    CB2PDF::Converter.seven_zip_path = '/usr/bin/env/7z'
      
    # convert comic1.cbr into C:\comics\pdfs\comic1.pdf
    pdf_file = CB2PDF::Converter.convert('C:\comics\comic1.cbr', 'C:\comics\pdfs')
    
CLI:

    cb2pdf [-o output/dir] [--7z-output] [-7z-path path/to/7z.exe]
           file1.cbr [C:\\comics\\**\\*.cbz file3.cb7 ...]
           
As you can see you can use wildcards in file paths that are compatible with `Dir::glob`.
