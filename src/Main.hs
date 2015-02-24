{-# Language OverloadedStrings #-}

module Main where

import Control.Exception (SomeException, try)
import Control.Monad (forever)
import qualified Data.ByteString as BS
import Data.UUID (toASCIIBytes)
import System.Random (randomIO)


main :: IO ()
main = do
        _ <- try loop :: IO (Either SomeException ())
        return ()
  where
      loop :: IO ()
      loop = forever $ do
                line <- BS.getLine
                uuid <- randomIO
                BS.putStr $ toASCIIBytes uuid
                BS.putStr "\t"
                BS.putStrLn line
