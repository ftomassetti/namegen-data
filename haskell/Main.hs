import System.IO
import qualified Data.List as L
import qualified Data.Map.Strict as M
import Data.List.Split

citiesFileName = "citynames/worldcitiespop.txt"

type NamesExamples = M.Map String [String]

-- It is written as an IO Action only as a cheap trick to force strict evaluation.
-- Please, forgive me and my Haskell sins
processFields :: [String] -> NamesExamples -> IO NamesExamples
processFields fields@(country:_:cityname:_) names = if M.notMember country names 
                                             then processFields fields (M.insert country [] names)
                                             else return (M.update (\ns -> Just (cityname:ns)) country names)

readingLoop :: NamesExamples -> Handle -> IO NamesExamples
readingLoop names inh = 
    do ineof <- hIsEOF inh
       if ineof
           then return $! names
           else do inpStr <- hGetLine inh
                   let fields = splitOn "," inpStr :: [String]
                   if (length fields) == 7 
                   then do names' <- processFields fields names
                           readingLoop names' inh
                   else do putStrLn $ "Skipping " ++ inpStr ++ " L=" ++ (show $ length fields)                   
                           readingLoop names inh

printNames :: NamesExamples -> IO ()
printNames names = do let Just itNames = M.lookup "it" names
                      let itNames' = L.sort itNames
                      putStrLn $ "It names " ++ (show itNames')

processCountry :: NamesExamples -> String -> IO ()
processCountry allnames country = do let Just names = M.lookup country allnames
                                     let names' = L.sort names
                                     putStrLn $ "Country " ++ country ++ " has " ++ (show $ length names')
                                     onh <- openFile ("citynames/citynames_" ++ country ++ ".txt") WriteMode
                                     hSetEncoding onh latin1
                                     let content = L.intercalate "\n" names'
                                     hPutStrLn onh content
                                     hClose onh


main :: IO ()
main = do putStrLn "Start processing city names"          
          inh <- openFile citiesFileName ReadMode          
          hSetEncoding inh latin1
          -- discard first line (headers)
          hGetLine inh
          names <- readingLoop M.empty inh          
          putStrLn $ "Countries: " ++ (show $ M.keys names)
          processCountry names "it"
          processCountry names "fr"
          processCountry names "de"
          processCountry names "eg"
          processCountry names "es"
          processCountry names "jp"
          processCountry names "ch"
          processCountry names "pl"
          hClose inh
          putStrLn "Done"