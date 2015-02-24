{-# Language OverloadedStrings #-}

module Main where

import Control.Exception (SomeException, try)
import Control.Monad (forever)
import qualified Data.ByteString as BS
-- import qualified Data.ByteString.Lazy as BS
import Data.ByteString.Lazy.Builder (Builder, byteString, hPutBuilder)
import Data.Monoid ((<>))
import Data.UUID (toASCIIBytes)
import GHC.IO.Handle (BufferMode(..), hSetBinaryMode, hSetBuffering)
import System.IO (stdout)
import System.Random (randomIO)

tab :: Builder
tab = byteString "\t"

newline :: Builder
newline = byteString "\n"

main :: IO ()
main = do
    _ <- try loop :: IO (Either SomeException ())
    return ()
  where
    loop :: IO ()
    loop = do
        hSetBinaryMode stdout True
        hSetBuffering stdout $ BlockBuffering Nothing
        forever $ do
            line <- BS.getLine
            uuid <- randomIO
            -- Using strict bytestrings and outputing them one at
            -- a time
            -- BS.putStr $ toASCIIBytes uuid
            -- BS.putStr "\t"
            -- BS.putStrLn line

            -- Using lazy bytestrings and outputing them after
            -- appendings them.
            -- BS.putStrLn $ toASCIIBytes uuid `BS.append` "\t" `BS.append` line

            -- Using builders.
            hPutBuilder stdout $ (byteString $ toASCIIBytes uuid)
                              <> tab
                              <> byteString line
                              <> newline

