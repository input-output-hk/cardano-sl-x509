{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_cardano_sl_x509 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/runner/.cabal/bin"
libdir     = "/home/runner/.cabal/lib/x86_64-linux-ghc-8.10.4/cardano-sl-x509-3.0.0-inplace-cardano-sl-x509-test"
dynlibdir  = "/home/runner/.cabal/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/runner/.cabal/share/x86_64-linux-ghc-8.10.4/cardano-sl-x509-3.0.0"
libexecdir = "/home/runner/.cabal/libexec/x86_64-linux-ghc-8.10.4/cardano-sl-x509-3.0.0"
sysconfdir = "/home/runner/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "cardano_sl_x509_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "cardano_sl_x509_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "cardano_sl_x509_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "cardano_sl_x509_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "cardano_sl_x509_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "cardano_sl_x509_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
