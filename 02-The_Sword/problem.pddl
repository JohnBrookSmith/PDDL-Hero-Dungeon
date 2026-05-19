(define 
    (problem destroying-the-sword)
    (:domain the-sword)
   (:objects rooma roomb roomc sword)
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (sword sword)
          (corridor rooma roomb)
          (corridor roomb roomc)
          (at roomb sword)
          (sword-not-destroyed-yet sword)
          (at-hero rooma))

   (:goal (and 
       (at-hero roomc)
       (not (sword-not-destroyed-yet sword))
       )))