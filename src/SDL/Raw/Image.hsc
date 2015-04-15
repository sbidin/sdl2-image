{-|

Module      : SDL.Raw.Image
Copyright   : (c) 2015 Siniša Biđin
License     : MIT
Maintainer  : sinisa@bidin.cc
Stability   : experimental

Raw bindings to the @SDL2_image@ library. No error-handling is done here. For
more information about specific function behaviour, see the @SDL2_image@
documentation.

-}

{-# LANGUAGE PatternSynonyms #-}

module SDL.Raw.Image
  (
  -- * Loading images
    Free
  , load
  , load_RW
  , Format
  , loadTyped_RW
  , loadCUR_RW
  , loadICO_RW
  , loadBMP_RW
  , loadPNM_RW
  , loadXPM_RW
  , loadXCF_RW
  , loadPCX_RW
  , loadGIF_RW
  , loadJPG_RW
  , loadTIF_RW
  , loadPNG_RW
  , loadTGA_RW
  , loadLBM_RW
  , loadXV_RW
  , loadWEBP_RW

  -- * Testing for formats
  , isCUR
  , isICO
  , isBMP
  , isPNM
  , isXPM
  , isXCF
  , isPCX
  , isGIF
  , isJPG
  , isTIF
  , isPNG
  , isLBM
  , isXV
  , isWEBP

  -- * Other
  , InitFlags
  , pattern IMG_INIT_JPG
  , pattern IMG_INIT_PNG
  , pattern IMG_INIT_TIF
  , pattern IMG_INIT_WEBP
  , init
  , getVersion
  , quit
  ) where

#include "SDL_image.h"

import Control.Monad.IO.Class (MonadIO, liftIO)
import Foreign.C.String       (CString)
import Foreign.C.Types        (CInt(..))
import Foreign.Ptr            (Ptr)
import Prelude         hiding (init)
import SDL.Raw.Types          (Version, Surface, RWops)

foreign import ccall "SDL_image.h IMG_Linked_Version"
  getVersion' :: IO (Ptr Version)

{-# INLINE getVersion #-}
getVersion :: MonadIO m => m (Ptr Version)
getVersion = liftIO getVersion'

type InitFlags = CInt

pattern IMG_INIT_JPG  = #{const IMG_INIT_JPG}
pattern IMG_INIT_PNG  = #{const IMG_INIT_PNG}
pattern IMG_INIT_TIF  = #{const IMG_INIT_TIF}
pattern IMG_INIT_WEBP = #{const IMG_INIT_WEBP}

foreign import ccall "SDL_image.h IMG_Init"
  init' :: InitFlags -> IO InitFlags

{-# INLINE init #-}
init :: MonadIO m => InitFlags -> m InitFlags
init = liftIO . init'

foreign import ccall "SDL_image.h IMG_Quit"
  quit' :: IO ()

{-# INLINE quit #-}
quit :: MonadIO m => m ()
quit = liftIO quit'

foreign import ccall "SDL_image.h IMG_Load"
  load' :: CString -> IO (Ptr Surface)

{-# INLINE load #-}
load :: MonadIO m => CString -> m (Ptr Surface)
load = liftIO . load'

-- | Should the 'Ptr' 'RWops' be freed after an operation? 1 for yes, 0 for no.
type Free = CInt

foreign import ccall "SDL_image.h IMG_Load_RW"
  load_RW' :: Ptr RWops -> Free -> IO (Ptr Surface)

{-# INLINE load_RW #-}
load_RW :: MonadIO m => Ptr RWops -> Free -> m (Ptr Surface)
load_RW src = liftIO . load_RW' src

-- | A case-insensitive string containing the desired format, e.g. @\"jpg\"@ or
-- @\"PNG\"@.
type Format = CString

foreign import ccall "SDL_image.h IMG_LoadTyped_RW"
  loadTyped_RW' :: Ptr RWops -> Free -> Format -> IO (Ptr Surface)

{-# INLINE loadTyped_RW #-}
loadTyped_RW :: MonadIO m => Ptr RWops -> Free -> Format -> m (Ptr Surface)
loadTyped_RW src free = liftIO . loadTyped_RW' src free

foreign import ccall "SDL_image.h IMG_LoadCUR_RW"
  loadCUR_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadCUR_RW #-}
loadCUR_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadCUR_RW = liftIO . loadCUR_RW'

foreign import ccall "SDL_image.h IMG_LoadICO_RW"
  loadICO_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadICO_RW #-}
loadICO_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadICO_RW = liftIO . loadICO_RW'

foreign import ccall "SDL_image.h IMG_LoadBMP_RW"
  loadBMP_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadBMP_RW #-}
loadBMP_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadBMP_RW = liftIO . loadBMP_RW'

foreign import ccall "SDL_image.h IMG_LoadPNM_RW"
  loadPNM_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadPNM_RW #-}
loadPNM_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadPNM_RW = liftIO . loadPNM_RW'

foreign import ccall "SDL_image.h IMG_LoadXPM_RW"
  loadXPM_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadXPM_RW #-}
loadXPM_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadXPM_RW = liftIO . loadXPM_RW'

foreign import ccall "SDL_image.h IMG_LoadXCF_RW"
  loadXCF_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadXCF_RW #-}
loadXCF_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadXCF_RW = liftIO . loadXCF_RW'

foreign import ccall "SDL_image.h IMG_LoadPCX_RW"
  loadPCX_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadPCX_RW #-}
loadPCX_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadPCX_RW = liftIO . loadPCX_RW'

foreign import ccall "SDL_image.h IMG_LoadGIF_RW"
  loadGIF_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadGIF_RW #-}
loadGIF_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadGIF_RW = liftIO . loadGIF_RW'

foreign import ccall "SDL_image.h IMG_LoadJPG_RW"
  loadJPG_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadJPG_RW #-}
loadJPG_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadJPG_RW = liftIO . loadJPG_RW'

foreign import ccall "SDL_image.h IMG_LoadTIF_RW"
  loadTIF_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadTIF_RW #-}
loadTIF_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadTIF_RW = liftIO . loadTIF_RW'

foreign import ccall "SDL_image.h IMG_LoadPNG_RW"
  loadPNG_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadPNG_RW #-}
loadPNG_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadPNG_RW = liftIO . loadPNG_RW'

foreign import ccall "SDL_image.h IMG_LoadTGA_RW"
  loadTGA_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadTGA_RW #-}
loadTGA_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadTGA_RW = liftIO . loadTGA_RW'

foreign import ccall "SDL_image.h IMG_LoadLBM_RW"
  loadLBM_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadLBM_RW #-}
loadLBM_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadLBM_RW = liftIO . loadLBM_RW'

foreign import ccall "SDL_image.h IMG_LoadXV_RW"
  loadXV_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadXV_RW #-}
loadXV_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadXV_RW = liftIO . loadXV_RW'

foreign import ccall "SDL_image.h IMG_LoadWEBP_RW"
  loadWEBP_RW' :: Ptr RWops -> IO (Ptr Surface)

{-# INLINE loadWEBP_RW #-}
loadWEBP_RW :: MonadIO m => Ptr RWops -> m (Ptr Surface)
loadWEBP_RW = liftIO . loadWEBP_RW'

foreign import ccall "SDL_image.h IMG_isCUR"
  isCUR' :: Ptr RWops -> IO CInt

{-# INLINE isCUR #-}
isCUR :: MonadIO m => Ptr RWops -> m CInt
isCUR = liftIO . isCUR'

foreign import ccall "SDL_image.h IMG_isICO"
  isICO' :: Ptr RWops -> IO CInt

{-# INLINE isICO #-}
isICO :: MonadIO m => Ptr RWops -> m CInt
isICO = liftIO . isICO'

foreign import ccall "SDL_image.h IMG_isBMP"
  isBMP' :: Ptr RWops -> IO CInt

{-# INLINE isBMP #-}
isBMP :: MonadIO m => Ptr RWops -> m CInt
isBMP = liftIO . isBMP'

foreign import ccall "SDL_image.h IMG_isPNM"
  isPNM' :: Ptr RWops -> IO CInt

{-# INLINE isPNM #-}
isPNM :: MonadIO m => Ptr RWops -> m CInt
isPNM = liftIO . isPNM'

foreign import ccall "SDL_image.h IMG_isXPM"
  isXPM' :: Ptr RWops -> IO CInt

{-# INLINE isXPM #-}
isXPM :: MonadIO m => Ptr RWops -> m CInt
isXPM = liftIO . isXPM'

foreign import ccall "SDL_image.h IMG_isXCF"
  isXCF' :: Ptr RWops -> IO CInt

{-# INLINE isXCF #-}
isXCF :: MonadIO m => Ptr RWops -> m CInt
isXCF = liftIO . isXCF'

foreign import ccall "SDL_image.h IMG_isPCX"
  isPCX' :: Ptr RWops -> IO CInt

{-# INLINE isPCX #-}
isPCX :: MonadIO m => Ptr RWops -> m CInt
isPCX = liftIO . isPCX'

foreign import ccall "SDL_image.h IMG_isGIF"
  isGIF' :: Ptr RWops -> IO CInt

{-# INLINE isGIF #-}
isGIF :: MonadIO m => Ptr RWops -> m CInt
isGIF = liftIO . isGIF'

foreign import ccall "SDL_image.h IMG_isJPG"
  isJPG' :: Ptr RWops -> IO CInt

{-# INLINE isJPG #-}
isJPG :: MonadIO m => Ptr RWops -> m CInt
isJPG = liftIO . isJPG'

foreign import ccall "SDL_image.h IMG_isTIF"
  isTIF' :: Ptr RWops -> IO CInt

{-# INLINE isTIF #-}
isTIF :: MonadIO m => Ptr RWops -> m CInt
isTIF = liftIO . isTIF'

foreign import ccall "SDL_image.h IMG_isPNG"
  isPNG' :: Ptr RWops -> IO CInt

{-# INLINE isPNG #-}
isPNG :: MonadIO m => Ptr RWops -> m CInt
isPNG = liftIO . isPNG'

foreign import ccall "SDL_image.h IMG_isLBM"
  isLBM' :: Ptr RWops -> IO CInt

{-# INLINE isLBM #-}
isLBM :: MonadIO m => Ptr RWops -> m CInt
isLBM = liftIO . isLBM'

foreign import ccall "SDL_image.h IMG_isXV"
  isXV' :: Ptr RWops -> IO CInt

{-# INLINE isXV #-}
isXV :: MonadIO m => Ptr RWops -> m CInt
isXV = liftIO . isXV'

foreign import ccall "SDL_image.h IMG_isWEBP"
  isWEBP' :: Ptr RWops -> IO CInt

{-# INLINE isWEBP #-}
isWEBP :: MonadIO m => Ptr RWops -> m CInt
isWEBP = liftIO . isWEBP'
