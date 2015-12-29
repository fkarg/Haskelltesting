module Complex where


type R = Double

data Complex = Co R R -- First is the Real part, second is the Imagenary
data Polar = Po R R -- First is the degree, second the distance
-- needed only later for 


instance Show Complex where
    show (Co r i) = show r ++ " " ++ show i ++ "i"

instance Num Complex where
    (+) = (+:)
    (*) = (*:)
    (-) = (-:)
    abs = cAbs
    signum = sigComplex
    fromInteger = fromIntegral'

instance Fractional Complex where
    (/) = (/:)
    recip = recipComplex
    fromRational = fromRational'

-- | converting a Rational number to a Complex one
fromRational' :: Rational -> Complex
fromRational' = undefined

-- | converting an Integer to a complex number
fromIntegral' :: Integral a => a -> Complex
fromIntegral' i = simpleComplex . fromIntegral $ i

-- | converting a Real number to a simple Complex one
simpleComplex :: Double -> Complex
simpleComplex d = Co d 0

-- | converting two Real numbers to a Complex one
toComplex :: Double -> Double -> Complex
toComplex r i = Co r i

infixl 9 ~:
(~:) :: Double -> Double -> Complex
r ~: i = toComplex r i

-- | adding two Complex numbers together
addComplex :: Complex -> Complex -> Complex
addComplex (Co r i) (Co rr ii) = Co (r + rr) (i + ii)

infixl 6 +:
(+:) :: Complex -> Complex -> Complex
r +: i = addComplex r i

-- | multiplying two Complex numbers together
multComplex :: Complex -> Complex -> Complex
multComplex (Co r i) (Co rr ii) = Co (r * rr - i * ii) (r * i + rr * ii)

infixl 8 *:
(*:) :: Complex -> Complex -> Complex
r *: i = multComplex r i

-- | subtracting two Complex numbers from one another
subComplex :: Complex -> Complex -> Complex
subComplex (Co r i) (Co rr ii) = Co (r - rr) (i - ii)

infixl 6 -:
(-:) :: Complex -> Complex -> Complex
r -: i = subComplex r i

-- | conjugating a Complex number
conjugate :: Complex -> Complex
conjugate (Co r i) = Co r (-i)
con = conjugate

-- | dividing two Complex numbers through one another
divComplex :: Complex -> Complex -> Complex
divComplex _ (Co 0 0) = error "can not divide through zero"
divComplex e@(Co a b) f@(Co c d) =  (e *: (con f)) /- (c^2 + d^2)

infixl 7 /:
(/:) :: Complex -> Complex -> Complex
r /: i = divComplex r i

-- | dividing a Complex number through a Real one
divcomplex :: Complex -> R -> Complex
divcomplex (Co a b) t = Co (a/t) (b/t)

infixl 7 /-
(/-) :: Complex -> Double -> Complex
i /- r = divcomplex i r

-- | returns the rounded absolute value of a Complex number
-- rounded because it's end type has to be Num 'a'
cAbs :: (Num a) => Complex -> a
cAbs c = fromIntegral . floor . sqrt $ a
    where (Co a b) = (con c) *: c

-- | returns a simpleComplex number with the result of the signum function
sigComplex :: Complex -> Complex
sigComplex (Co 0 0) = simpleComplex 0
sigComplex a = simpleComplex . signum $ e
    where (Co e _) = a /: (cAbs a)

-- | returns a Complex number in a pair of polar coordinates
toPolar :: Complex -> Polar
toPolar a@(Co r i) = undefined
        where b = cAbs a

recipComplex :: Complex -> Complex
recipComplex (Co 0 0) = undefined
recipComplex a = c /: a *: c
        where c = con a


-- mandelbrot :: IO ()


complexTest  = Co 3 5
complexTest2 = Co 5 3
complexTest3 = Co 7 2
complexTest4 = Co 2.5 3.3
complexTest5 = Co (-2) (-5)

