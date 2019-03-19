{-# LANGUAGE TemplateHaskell #-}

module Test.Cardano.X509.Configuration (tests) where

import           Cardano.X509.Configuration
import           Hedgehog (Gen, Property, Group, discover)
import           Hedgehog.Internal.TH (TExpQ)
import qualified Hedgehog as H
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import           Universum hiding (head, tail)

-- TODO(KS): Yes, this is too complicated to import since it requires a lot.
--roundTripTLSConfiguration :: Property
--roundTripTLSConfiguration = roundTripsAesonYamlShow 100 genTlsConfig

genTlsConfig :: Gen TLSConfiguration
genTlsConfig = TLSConfiguration <$> genCertConfig <*> genServerConfig <*> genClients

genCertConfig :: Gen CertConfiguration
genCertConfig = CertConfiguration <$> genString <*> genString <*> genInt

genServerConfig :: Gen ServerConfiguration
genServerConfig = ServerConfiguration <$> genCertConfig <*> genNonEmptyString

genClients :: Gen [CertConfiguration]
genClients = Gen.list (Range.linearFrom 0 0 10) genCertConfig

genString :: Gen String
genString = Gen.string (Range.linearFrom 0 0 10) Gen.ascii

genNonEmptyString :: Gen (NonEmpty String)
genNonEmptyString = do
  len <- Gen.integral (Range.linearFrom 0 0 20)
  genNonEmpty genString len

genNonEmpty :: Gen a -> Int -> Gen (NonEmpty a)
genNonEmpty genA len = do
  head <- genA
  tail <- Gen.list (Range.linear 0 (fromIntegral len)) genA
  pure (head :| tail)

genInt :: Gen Int
genInt = Gen.integral (Range.linearFrom 10 10 20)

tests :: IO Bool
tests = H.checkParallel $$(discover)

