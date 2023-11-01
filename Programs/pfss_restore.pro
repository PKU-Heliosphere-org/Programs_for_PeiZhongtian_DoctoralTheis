pro pfss_restore, restfile, refresh=refresh,loud=loud
;+
;   Name: pfss_restore
;
;   Purpose: routine to restore input pfss 'save' file and update pfss common
;
;   Input Parameters:
;      restfile - the pfss file to restore
;
;   Output Parameters:
;      NONE - (all output via common block)
;
;   Keyword Parameters:
;      refresh - if set, force restore even if same as last restored file 
;
;   Side Effects:
;      Updates pfss common block: pfss_data_block
;
;   Common Blocks:

;      YES: pfss_data_block - common used by pfss_viewer et al
;           pfss_restore_blk - restore file from last call
;
;   History:
;      5-Dec-2004 - S.L.Freeland
;     26-Jan-2004 - S.L.Freeland - add /RELAX to 
;     25-sep-2006 - S.L.Freeland - use pfss_data_block.pro for common define
;-

common pfss_restore_blk, lastrestfile

@pfss_data_block

loud=keyword_set(loud)

if not data_chk(restfile,/string) then begin 
   box_message,'Need an input pfss (idl) save file name...., bailing'
   return
endif 


if n_elements(lastrestfile) eq 0 then lastrestfile=''  ; init local common 
restoreit=keyword_set(refresh) or restfile(0) ne lastrestfile

if not file_exist(restfile(0)) and restoreit then begin 
   if strpos(restfile(0),'http') eq 0 then begin 
      break_url,restfile(0),IP,subdir,file
      outdir=get_temp_dir()
      locfile=concat_dir(outdir,file)
      if not file_exist(locfile) then begin
         box_message,'Retrieving pfss Bfield file via http...'
         sock_copy,restfile(0),out_dir=outdir, $ 
            prog=is_member(!d.name,'win,x,mac',/wc,/ignore_case)
 
         restfile=locfile         ; url -> local name
      endif else begin
         box_message,'File> ' + locfile +' already local...'
         restfile=locfile
      endelse
   endif
   if not file_exist(restfile(0)) then begin 
      box_message,'Cannot find restore file> ' + restfile(0) + ' ,bailing..'
      return
   endif
endif

if restoreit then begin 
   box_message,['Restoring file>> ',restfile,'...Please be patient']
   restore, file=restfile, /relax 
   lastrestfile=restfile(0)
   box_message,'Done with restore...'
endif else if restfile(0) eq lastrestfile and loud then $
   box_message,['Same file as last time so not re-restored',$
               'Use /REFRESH to force re-restore'] 

return
end
